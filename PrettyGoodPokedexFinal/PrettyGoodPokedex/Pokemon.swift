//
//  Pokemon.swift
//  PrettyGoodPokedex
//
//  Created by Kevin Tan on 1/29/18.
//  Copyright © 2018 ACM Hack. All rights reserved.
//

import Foundation

class Pokemon {
    
    var name: String
    var imageURL: URL
    var type: String
    var weight: String
    
    init(name: String, imageURL: String, type: String, weight: String) {
        self.name = name
        self.imageURL = URL(string: imageURL)!
        self.type = type
        self.weight = weight
    }
    
}
