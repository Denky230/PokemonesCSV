//
//  Pokedex.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 19/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

class PokeData {
    
    static let pokemones: [Pokemon] = [
            Pokemon(name: "Squirtle", type: .WATER),
            Pokemon(name: "Charmander", type: .FIRE),
            Pokemon(name: "Bulbasaur", type: .GRASS, subtype: .POISON),
            Pokemon(name: "Salamence", type: .DRAGON, subtype: .FLYING)
    ]
}
