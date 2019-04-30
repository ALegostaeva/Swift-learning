//
//  Person.swift
//  Project12a
//
//  Created by Александра Легостаева on 28/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    var name: String
    var image: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
}
