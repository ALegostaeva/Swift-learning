//
//  ViewController.swift
//  project7a
//
//  Created by Александра Легостаева on 15/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var filtered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearch))
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filtered {
            return filteredPetitions.count
        } else {
            return petitions.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition: Petition
        if filtered {
            petition = filteredPetitions[indexPath.row]
        } else {
            petition = petitions[indexPath.row]
        }
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        if filtered {
            vc.detailItem = filteredPetitions[indexPath.row]
        } else {
            vc.detailItem = petitions[indexPath.row]
        }
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func fetchJSON () {
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=50"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=50"
            //            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showSearch() {
        let ac = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Go", style: .default) {[weak self, weak ac] action in
            guard let filter = ac?.textFields?[0].text else {return}
            self?.searching(filter)
            })
        present(ac, animated: true)
    }
    
    func searching(_ userFilter: String) {
        debugPrint("searching \(userFilter)")
        filteredPetitions = petitions.filter {$0.body.contains(userFilter) || $0.title.contains(userFilter)}
        filtered = true
        tableView.reloadData()
    }
}

