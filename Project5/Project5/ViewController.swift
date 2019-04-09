//
//  ViewController.swift
//  Project5
//
//  Created by Александра Легостаева on 05/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var words = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let path = Bundle.main.url(forResource: "startRu", withExtension: "txt") {
            if let wordsFromFile = try? String(contentsOf: path) {
                words = wordsFromFile.components(separatedBy: "/n")
            }
        }
        
        if words.isEmpty {
            words += ["cleaner"]
        }
       
        startGame()
    }


    func startGame() {
        title = words.randomElement()
        usedWords.removeAll()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer () {
        
        let viewForAnswer = UIAlertController(title: "Напиши слово", message:  nil, preferredStyle: .alert)
        viewForAnswer.addTextField()
        
        let submitAnswer = UIAlertAction(title: "Добавить", style: .default) {[weak self, weak viewForAnswer] action in
            guard let answer = viewForAnswer?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        viewForAnswer.addAction(submitAnswer)
        present(viewForAnswer, animated: true)
    }
    
    func submit(_ answer: String){
        usedWords += [answer]
        tableView.reloadData()
    }
}

