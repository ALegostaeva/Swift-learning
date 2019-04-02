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
    
    var gamerScore: Int = 0
    var correctAnswer: Int = 0
    var countries = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        
        askCountry()
        labelScore.text = "You score is: \(gamerScore)"
        
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
        
        if correctAnswer == sender.tag {
            title = "Yep! Correct"
            gamerScore += 1
            labelScore.text = "You score is: \(gamerScore)"
        } else {
            title = "Oops! Wrong"
            gamerScore -= 1
            labelScore.text = "You score is: \(gamerScore)"
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(gamerScore)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askCountry))
        present(ac, animated: true)
    }
    
}

