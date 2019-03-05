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
    var image: UIImage!
    var pokeballs: Int
    var pokemons: [Pokemon]
    var pokedex: [Pokemon]
    
    init(named name: String) {
        self.name = name
        self.pokeballs = 0
        self.pokemons = [Pokemon]()
        self.pokedex = [Pokemon]()
    }
    convenience init(named name: String, image: UIImage) {
        self.init(named: name)
        self.image = image
    }
}
