//
//  PokemonSubtype.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 29/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

enum PokemonSubtype: String, CaseIterable {
    
    case EMPTY = ""
    case FLYING = "Flying"
    case GROUND = "Ground"
    case GRASS = "Grass"
    case POISON = "Poison"
    case BUG = "Bug"
    case PSYCHIC = "Psychic"
    case FIGHTING = "Fighting"
    
    static func getEnumFromString(name: String) -> PokemonSubtype {
        return self.allCases.first{ "\($0)" == name }!
    }
}
