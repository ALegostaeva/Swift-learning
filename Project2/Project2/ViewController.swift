//
//  ViewController.swift
//  Project2
//
//  Created by Александра Легостаева on 01/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var labelScore: UILabel!
    
    var gamerScore: Int = 0 {
        didSet{
            labelScore.text = "Score: \(gamerScore). Lifes:\(lifes)"
        }
    }
    
    var bestScore = 0
    
    var lifes: Int = 3 {
        didSet{
            labelScore.text = "Score: \(gamerScore). Lifes:\(lifes)"
        }
    }
    
    var correctAnswer: Int = 0
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New game", style: .plain, target: self, action: #selector(newGame))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfo))
        
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        newGame()
        
    }
    
    @objc func newGame(action: UIAlertAction! = nil) {
        gamerScore = 0
        lifes = 3
        labelScore.text = "Score: \(gamerScore). Lifes:\(lifes)"
        askCountry()
    }
    
    func askCountry (action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 3, options: .curveEaseOut, animations: {sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)}) { finished in
        
            if self.correctAnswer == sender.tag {
                self.title = "Yep! Correct"
                self.gamerScore += 1
                self.askCountry()
            } else {
                self.gamerScore -= 1
                self.lifes -= 1
                if self.lifes < 0 {
                    if self.bestScore < self.gamerScore {
                        self.bestScore = self.gamerScore
                    }
                    
                    let endGame = UIAlertController(title: "Game over", message: "Your score is \(self.gamerScore)", preferredStyle: .alert)
                    endGame.addAction(UIAlertAction(title: "Start new game", style: .default, handler: self.newGame))
                    self.present(endGame, animated: true)
                    
                } else {
                    self.showAnswer(titleAlert: "Oops! Wrong", messageAlert: "It is \(self.countries[sender.tag].uppercased()).Your score is \(self.gamerScore)")
                }
            }
        }
        sender.transform = .identity
    }
    
    func showAnswer (titleAlert: String, messageAlert: String) {
        let ac = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askCountry))
        present(ac, animated: true)
    }
    
    @objc func showInfo() {
        let message =
        """
            Game GUESS FLAGS
        
        You have only 3 lifes. With every wrong answer you are losing 1 life.
        
        
        The best score is: \(bestScore)
        """
        
        let ac = UIAlertController(title: "Information", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
}

