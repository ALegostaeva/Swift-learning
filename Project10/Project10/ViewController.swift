//
//  ViewController.swift
//  Project10
//
//  Created by Александра Легостаева on 19/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
//        picker.sourceType = .camera
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(image: imageName, name: "Unknown")
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
                fatalError("Unable to dequeue PersonCell.") }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
//         alert about 3 action (rename, delete and cancel)
        let acChange = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        acChange.addAction(UIAlertAction(title: "Rename person", style: .default) { [weak self] _ in
            
//            action rename person
                let acRename = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
                acRename.addTextField()
                acRename.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                acRename.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak acRename] _ in
                    
                    guard let newName = acRename?.textFields?[0].text else { return }
                    person.name = newName
                    
                    self?.collectionView.reloadData()
                })
                self?.present(acRename, animated: true)
            })
        
//        action delete person
        acChange.addAction(UIAlertAction(title: "Delete person", style: .default) { [weak self] _ in

            //            accepting for delete person with 2 oprions: delete and cancel
            let acAccept = UIAlertController(title: "This person will delete from the list.", message: "Are you sure?", preferredStyle: .alert)
            acAccept.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            acAccept.addAction(UIAlertAction(title: "Delete", style: .default) { [weak self] _ in

                guard let indexOfPerson = self?.people.firstIndex(of: person) else { return }
                self?.people.remove(at: indexOfPerson)

                self?.collectionView.reloadData()
            })

            self?.present(acAccept, animated: true)
        })
        
//        action cancel
        acChange.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(acChange,animated: true)
        
    }
    
}

