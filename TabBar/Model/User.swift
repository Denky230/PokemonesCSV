//
//  User.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 22/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class User {
    
    var name: String
    var image: UIImage
    var pokeballs: Int
    
    let pokemons: [Pokemon]
    let pokedex: [Pokemon]
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
        self.pokeballs = 0
        self.pokemons = [Pokemon]()
        self.pokedex = [Pokemon]()
    }
    convenience init(name: String) {
        self.init(name: name, image: UIImage())
    }
}
