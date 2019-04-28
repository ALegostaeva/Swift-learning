//
//  Person.swift
//  Project12a
//
//  Created by Александра Легостаева on 28/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String
    var image: String
    
    init(image: String, name: String) {
        self.image = image
        self.name = name
    }
}
