//
//  Pokemon.swift
//  TabBar
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class Pokemon {
    
    var sprite: UIImage
    let name: String
    let type: PokemonType
    let subtype: PokemonType
    let description: String
    
    init(sprite: UIImage, name: String, type: PokemonType, subtype: PokemonType, description: String) {
        self.sprite = sprite
        self.name = name
        self.type = type
        self.subtype = subtype
        self.description = description
    }
    convenience init(sprite: UIImage, name: String, type: PokemonType, description: String) {
        self.init(sprite: sprite, name: name, type: type, subtype: .EMPTY, description: description)
    }
    
    // TEST - Remove when ready to read from CSV
//    convenience init(name: String, type: PokemonType, subtype: PokemonType) {
//        self.init(sprite: UIImage(named: "pokemon")!, name: name, type: type, subtype: subtype, description: "")
//    }
//    convenience init(name: String, type: PokemonType) {
//        self.init(name: name, type: type, subtype: .EMPTY)
//    }
}
