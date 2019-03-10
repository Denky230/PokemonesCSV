//
//  AppManager.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 26/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

var loggedUser: User!
var pokemones: [Pokemon] = [Pokemon]()
var unknownPokemons: [Pokemon] = [Pokemon]()

let manager: AppManager = AppManager()

class AppManager {
    
    func checkPokemonDetails(context: UIViewController, pokemon: Pokemon) {
        // Instantiate a PokemonDetailsViewController
        let vc = context.storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Assign selected Pokemon
        vc.pokemon = pokemon
        
        // Go to PokemonDetailsViewController
        context.navigationController?.pushViewController(vc, animated: true)
    }
}
