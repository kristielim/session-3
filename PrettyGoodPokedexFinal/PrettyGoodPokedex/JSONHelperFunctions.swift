//
//  JSONHelperFunctions.swift
//  PrettyGoodPokedex
//
//  Created by Kevin Tan on 1/28/18.
//  Copyright © 2018 ACM Hack. All rights reserved.
//

import Foundation

fileprivate func getJSON() -> [Any] {
    if let filePath = Bundle.main.path(forResource:"pokedex", ofType:"json") {
        if let data = NSData(contentsOfFile: filePath) {
            do {
                let json = try JSONSerialization.jsonObject(with: data as Data, options: []) as! [String:Any]
                return json["pokemon"] as! [Any]
            } catch let error as NSError {
                print("Error occured while loading json file")
                print(error.description)
                return []
            }
        }
    }
    return []
}

func getPokemon() -> [Pokemon] {
    
    let data = getJSON()
    var pokemonArray: [Pokemon] = []
    
    for object in data {
        
        var pokemon = object as! Dictionary<String, Any>
        var types = pokemon["type"] as! [String]
        
        let name = pokemon["name"] as! String
        let url = pokemon["img"] as! String
        let primaryType = types[0]
        let weight = pokemon["weight"] as! String
        
        let newPokemon = Pokemon(name: name, imageURL: url, type: primaryType, weight: weight)
        pokemonArray.append(newPokemon)
        
    }
    
    return pokemonArray
    
}
