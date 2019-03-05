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
    case GHOST = "Ghost"
    case EMPTY = ""
    
    static func getSpriteFromEnum(const: PokemonType) -> UIImage {
        return UIImage(named: const.rawValue)!
    }
}
