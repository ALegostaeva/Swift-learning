//
//  TableViewController.swift
//  Project4
//
//  Created by Александра Легостаева on 05/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com", "imgdr.com.au"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let webView = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
            webView.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(webView, animated: true)
        }
        
    }

}
