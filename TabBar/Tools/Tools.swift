//
//  Tools.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 01/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import Foundation
import UIKit

let tools: Tools = Tools()

class Tools {
    
    func loadPokemons() {
        // Get CSV file path
        let path = Bundle.main.path(forResource: "pokemons", ofType: "csv")!
        
        // Restore user Pokedex + Pokemons from phone memory
        let pokedex = userDefaults.fetchPokedex()
        let pokemons = userDefaults.fetchPokemons()
        
        // Parse CSV
        let csv = try! CSVReader(contentsOfURL: path)
        // Create new Pokemon for each row in CSV
        for row in csv.rows {
            // Get UIImage from CSV URL
            let image = imageFromURL(url: row["PNG"]!)
            let pokemon = Pokemon(
                id: Int(row["Number"]!)!,
                sprite: image,
                name: row["Pokemon"]!,
                type: PokemonType(rawValue: row["Type 1"]!)!,
                subtype: PokemonType(rawValue: row["Type 2"]!)!,
                description: row["Description"]!
            )
            
            // Check if Pokemon is known / owned by user
            if pokedex.contains(where: { $0 == pokemon.id }) {
                loggedUser.pokedex.append(pokemon)
            }
            if pokemons.contains(where: { $0 == pokemon.id }) {
                loggedUser.pokemons.append(pokemon)
            }
            
            // Add Pokemon to app Pokemon pool
            pokemones.append(pokemon)
        }
    }    
    func imageFromURL(url: String) -> UIImage {
        let url = URL(string: url)
        let data = try! Data(contentsOf: url!)
        let image: UIImage = UIImage(data: data)!
        return image
    }
}
