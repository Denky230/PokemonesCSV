//
//  Tools.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 01/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import Foundation
import UIKit

class Tools {
    
    func loadPokemons() {
        // Get CSV file path
        let path = Bundle.main.path(forResource: "pokemons", ofType: "csv")!
        
        do {
            // Parse CSV
            let csv = try CSVReader(contentsOfURL: path)
            // Create new Pokemon for each row in CSV
            for row in csv.rows {
                // Get UIImage from CSV URL
                let url = URL(string: row["PNG"]!)
                let data = try Data(contentsOf: url!)
                let image: UIImage = UIImage(data: data)!
                
                let pokemon = Pokemon(
                    id: Int(row["Number"]!)!,
                    sprite: UIImage(named: "profile_unselected")!,
                    name: row["Pokemon"]!,
                    type: PokemonType(rawValue: row["Type 1"]!)!,
                    subtype: PokemonType(rawValue: row["Type 2"]!)!,
                    description: row["Description"]!
                )
                
                pokemones.append(pokemon)
            }
            
        } catch let error as NSError {
            print("Error decodificando el CSV", error)
        }
    }
}
