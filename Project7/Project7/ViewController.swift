//
//  ViewController.swift
//  Project7
//
//  Created by Александра Легостаева on 14/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{

    var characters = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Charcters of StarWars"
        
        let urlString = "https://swapi.co/api/people/"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                debugPrint(data)
                parse(json: data)
            } else {debugPrint("not data")}
        } else {debugPrint("not url")}
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let character = characters[indexPath.row]
        debugPrint(character)
        cell.textLabel?.text = character.name
//        cell.detailTextLabel?.text = "Test"
        cell.detailTextLabel?.text = character.birth_year
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        viewController.detailCharacter = characters[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        debugPrint("here parse")
        debugPrint(json)
        
        if let jsonCharacters = try? decoder.decode(Characters.self, from: json) {
            characters = jsonCharacters.results
            debugPrint("here decode")
            tableView.reloadData()
        }
    }
    
}

