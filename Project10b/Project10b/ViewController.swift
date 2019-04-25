//
//  ViewController.swift
//  Project 10b
//
//  Created by Александра Легостаева on 25/03/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadPicturies), with: nil)
    }
    
    @objc func loadPicturies() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("IMG_") {
                pictures.append(item)
            }
        }
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue PersonCell.") }
        
        cell.name.text = pictures[indexPath.item]
        cell.image.image = UIImage(named: pictures[indexPath.row])
        
        cell.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 3
        cell.image.resizableSnapshotView(from: CGRect(x: 0, y: 0, width: 100, height: 100), afterScreenUpdates: false, withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        cell.image.contentMode = .scaleAspectFill
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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


