//
//  ViewController.swift
//  Project5
//
//  Created by Александра Легостаева on 05/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var score: UILabel!
    
    var words = [String]()
    var usedWords = [String]()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        if let path = Bundle.main.url(forResource: "startRu", withExtension: "txt") {
            if let wordsFromFile = try? String(contentsOf: path) {
                words = wordsFromFile.components(separatedBy: "\n")
            }
        }
        
        if words.isEmpty {
            words += ["cleaner"]
        }
       
        startGame()
    }


    @objc func startGame() {
        title = words.randomElement()
        score.text = "Счёт: 0"
        usedWords.removeAll()
        tableView.reloadData()
    }
    
//    table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
//    enter word from user
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
//    checking answer and adding to the table
    func submit(_ answer: String){
        let lowerCasedAnswer = answer.lowercased()

        if checkIsPossible(word: lowerCasedAnswer) {
            if checkIsOriginal(word: lowerCasedAnswer) {
                if checkIsReal(word: lowerCasedAnswer) {
                    usedWords.insert(lowerCasedAnswer, at: 0)
                    score.text = ("(Счёт: \(usedWords.count))")

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
//    Checks for user's answer: possible, original, spelling
    func checkIsPossible(word:String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                showErrorMessage(title: "Ай-ай-ай", message: "Слово \"\(word)\" нельзя составить из \"\(title!)\". Подумай еще.")
                return false
            }
        }
        return true
    }
    
    func checkIsOriginal(word:String) -> Bool {
        
        if !usedWords.contains(word) {
            return true
        } else {
            showErrorMessage(title: "Упс", message: "Cлово \"\(word)\" уже есть в списке. Попробуй другое.")
            return false
        }
    }
    
    func checkIsReal(word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "ru")
        
        if !(word.utf16.count > 2) {
            showErrorMessage(title: "Увы", message: "Cлово \"\(word)\" слишком короткое. Попробуй другое.")
            return false
        }
        if (word == title!) {
            showErrorMessage(title: "Увы", message: "Cлово \"\(word)\" полностью совпадает с тем, что дано. Попробуй другое.")
            return false
        }
        if !(misspelledRange.location == NSNotFound) {
            showErrorMessage(title: "Увы", message: "Cлово \"\(word)\" не существует. Попробуй другое.")
            return false
        }
        
        return true
    }
//alert in case of error word from user
    func showErrorMessage (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        present(alert, animated: true)
    }

}

