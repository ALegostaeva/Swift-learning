//
//  ViewController.swift
//  Project39
//
//  Created by Александра Легостаева on 13/05/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var playData = PlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.allWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let word = playData.allWords[indexPath.row]
        cell.textLabel!.text = word
        
        cell.detailTextLabel!.text = "\(playData.wordCounts.count(for: word))"
        
        return cell
    }


}

