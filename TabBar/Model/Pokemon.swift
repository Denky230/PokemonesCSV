//
//  Pokemon.swift
//  TabBar
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class Pokemon {
    
    let id: Int
    var sprite: UIImage
    let name: String
    let type: PokemonType
    let subtype: PokemonType
    let description: String
    
    init(id: Int, sprite: UIImage, name: String, type: PokemonType, subtype: PokemonType, description: String) {
        self.id = id
        self.sprite = sprite
        self.name = name
        self.type = type
        self.subtype = subtype
        self.description = description
    }
}

// Compare Pokemons by ID
extension Pokemon: Comparable {
    
    static func < (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id < rhs.id
    }
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}
