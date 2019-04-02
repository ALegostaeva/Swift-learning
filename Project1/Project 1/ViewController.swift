//
//  ViewController.swift
//  Project 1
//
//  Created by Александра Легостаева on 21/03/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("IMG_") {
                pictures.append(item)
            }
        }
        print(pictures)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailView = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailView.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    @objc func shareTapped() {
        
        let textForShare: [Any] = ["This app is my favorite", URL(string: "https://www.apple.com")!]
        
        let viewCon = UIActivityViewController(activityItems: [textForShare], applicationActivities: nil)
        viewCon.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewCon, animated: true)
    }

}

