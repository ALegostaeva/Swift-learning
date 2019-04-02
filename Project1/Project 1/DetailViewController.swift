//
//  DetailViewController.swift
//  Project 1
//
//  Created by Александра Легостаева on 25/03/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        if let imageForLoad = selectedImage {
            
            title = "View Picture \(imageForLoad)"
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
            
            imageView.image = UIImage(named: imageForLoad)
        }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.hidesBarsOnTap = true
    }
    
    @objc func shareTapped () {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let viewCon = UIActivityViewController(activityItems: ["\(image)",image], applicationActivities: [])
        viewCon.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewCon, animated: true)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.hidesBarsOnTap = true
    }
    
}
