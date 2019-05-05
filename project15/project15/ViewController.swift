//
//  ViewController.swift
//  project15
//
//  Created by Александра Легостаева on 02/05/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var buttonsView: UIView!

    @IBAction func tapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .transitionCurlDown, animations:{sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)})
            { finished in
                sender.transform = .identity
            }
        case 1:
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:{sender.transform = CGAffineTransform(translationX: 0, y: -10)})
            { finished in
                sender.transform = .identity
            }
        case 2:
            UIView.animate(withDuration: 0.1, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:{sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)})
            { finished in
                sender.transform = .identity
            }
        case 3:
            UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:{
                sender.alpha = 0.1
                sender.backgroundColor = UIColor.green})
            { finished in
                sender.alpha = 1
                sender.backgroundColor = UIColor.gray
            }
        case 4:
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:{sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi/10)}){ finished in
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:{sender.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/10)}){ finished in
                    sender.transform = .identity
                }
            }
        case 5:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .transitionFlipFromTop, animations:{sender.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)}) { finished in
                sender.backgroundColor = UIColor.gray
            }
        case 6:
            UIView.transition(with: self.view, duration: 1, options: .transitionFlipFromTop, animations:{sender.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)}, completion: nil)
        case 7:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:{sender.transform = CGAffineTransform(scaleX: 3, y: 3)}) { finished in
                sender.transform = .identity
            }
        case 8:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations:{sender.transform = CGAffineTransform(scaleX: 3, y: 3)}) { finished in
                sender.transform = .identity
            }
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        buttonsView.center = CGPoint(x: 512, y: 384)
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        let widht = 750/3
        let height = 320/3
        var tag = 0
        
        for row in 0..<3 {
            for col in 0..<3 {
                let button = UIButton(type: .system)
                button.tag = tag
                tag += 1
                button.titleLabel?.font = UIFont.systemFont(ofSize: 33)
                button.backgroundColor = UIColor.gray
                
                
                button.setTitle("animation \(tag)", for: .normal)
                
                let frame = CGRect(x: col*widht, y: row*height, width: widht, height: height)
                button.frame = frame
                button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
                
                buttonsView.addSubview(button)
            }
        }
    }


}

