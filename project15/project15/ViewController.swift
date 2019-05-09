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
    private var animator = UIViewPropertyAnimator()
    private var spring = UISpringTimingParameters()

    @IBAction private func tapped(_ sender: UIButton) {
        
        animator.stopAnimation(true)
        
        switch sender.tag {
        case 0:
            animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut, animations: {
                sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            })
            debugPrint(sender.tag)
        case 1:
            animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut, animations: {
                sender.transform = CGAffineTransform(translationX: 0, y: -10)
            })
        case 2:
            animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut, animations: {sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)})
        case 3:
            animator = UIViewPropertyAnimator(duration: 0.1, curve: .easeOut, animations:{
                sender.alpha = 0.9
                sender.backgroundColor = UIColor.darkGray})
        case 4:
            animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations:{sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi/10)})
        case 5:
            animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {sender.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)})
        case 6:
            animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {sender.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)})
//            animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: UISpringTimingParameters(mass: 1, stiffness: 1, damping: 1, initialVelocity: CGVector(dx: 0, dy: 4)))
            
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
                button.addTarget(self, action: #selector(tapped), for: [.touchDown, .touchDragEnter])
                button.addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchDragExit, .touchCancel])
                
                buttonsView.addSubview(button)
                
            }
        }
    }

    @IBAction private func touchUp(_ sender: UIButton) {
        
        debugPrint("touchUp", sender.tag)
        sender.transform = .identity
        sender.backgroundColor = UIColor.gray
        sender.alpha = 1
        animator.startAnimation()
    }
}

