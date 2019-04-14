//
//  Petition.swift
//  Project7
//
//  Created by Александра Легостаева on 14/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

struct Character: Codable {
    var name: String
    var height: String
    var mass: String
    var hair_color: String
    var skin_color: String
    var eye_color: String
    var birth_year: String
    var gender: String
    var homeworld: String
    var films: [String]
    var species: [String]
    var vehicles: [String]
    var starships: [String]
}
