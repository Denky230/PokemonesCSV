//
//  UserDefault.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 07/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

let userDefaults: UserDefault = UserDefault()

class UserDefault {
    
    let defaults = UserDefaults.standard
    
    enum Keys {
        static let name = "name"
        static let image = "image"
        static let pokedex = "pokedex"
        static let pokemons = "pokemons"
    }
    
    func saveUserProfileData() {
        defaults.set(loggedUser.name, forKey: Keys.name)
    }
    func savePokedex() {
        var pokedexIds = [Int]()
        loggedUser.pokedex.forEach { pokedexIds.append($0.id) }
        defaults.set(pokedexIds, forKey: Keys.pokedex)
    }
    func savePokemons() {
        var pokemonsIds = [Int]()
        loggedUser.pokemons.forEach { pokemonsIds.append($0.id) }
        defaults.set(pokemonsIds, forKey: Keys.pokemons)
    }
    
    func restoreUserProfileData() {
        let name = defaults.string(forKey: Keys.name)!
        loggedUser = User(named: name)
    }
    func fetchPokedex() -> [Int] {
        var pokedex = [Int]()
        if let p = defaults.array(forKey: Keys.pokedex) {
            pokedex = p as! [Int]
        }
        return pokedex
    }
    func fetchPokemons() -> [Int] {
        var pokemons = [Int]()
        if let p = defaults.array(forKey: Keys.pokemons) {
            pokemons = p as! [Int]
        }
        return pokemons
    }
}
