//
//  Petition.swift
//  project7a
//
//  Created by Александра Легостаева on 15/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
