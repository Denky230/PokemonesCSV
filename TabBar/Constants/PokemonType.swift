//
//  PokemonType.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 29/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

enum PokemonType: String, CaseIterable {
    
    case FIRE = "Fire"
    case WATER = "Water"
    case GRASS = "Grass"
    case ICE = "Ice"
    case BUG = "Bug"
    case POISON = "Poison"
    case ELECTRIC = "Electric"
    case GROUND = "Ground"
    case ROCK = "Rock"
    case NORMAL = "Normal"
    case FLYING = "Flying"
    case FIGHTING = "Fighting"
    case PSYCHIC = "Psychic"
    case DRAGON = "Dragon"
    case EMPTY = ""
    
    static func getEnumFromString(name: String) -> PokemonType {
        return self.allCases.first{ "\($0)" == name }!
    }
    
    static func getSpriteFromEnum(value: PokemonType) -> UIImage {
        let spriteName: String = value.rawValue
        return UIImage(named: spriteName)!
    }
}
