//
//  AppManager.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 26/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import Foundation
import UIKit

var loggedUser: User = User(named: "Denky")
var pokemones: [Pokemon] = [Pokemon]()

class AppManager {
    
    static func loadPokemons() {
        // Get CSV file path
        let path = Bundle.main.path(forResource: "pokemons", ofType: "csv")!
        
        do {
            // Parse CSV
            let csv = try CSVReader(contentsOfURL: path)
            // Loop CSV data and create new Pokemon with each row
            for row in csv.rows {
                let pokemon = Pokemon(
                    sprite: UIImage(),
                    name: row["Pokemon"]!,
                    type: PokemonType(rawValue: row["Type 1"]!)!,
                    subtype: PokemonType(rawValue: row["Type 2"]!)!,
                    description: row["Description"]!
                )
                
                // Get UIImage from URL
                imageFromURL(imageURL: row["PNG"]!) { (imgRecovered) -> Void in
                    if let image = imgRecovered {
                        DispatchQueue.main.async {
                            pokemon.sprite = image
                            return
                        }
                    }
                }
                
                pokemones.append(pokemon)
            }
            
        } catch let error as NSError {
            print("Error decodificando el CSV", error)
        }
    }
    
    static func imageFromURL(imageURL: String, completion: @escaping (_ image: UIImage?) -> ()) {
        let imgURL = URL(string: imageURL)!
        
        // Creates a default configuration object which uses
        // the disk-persisted global cache, credential and cookie storage objects.
        // Creamos la sesion
        let session = URLSession(configuration: .default)
        
        // Obtengo la URL definiendola del tipo data, el cod de respuesta y el error
        session.dataTask(with: imgURL) { (data, response, error) in
            // Una vez descargada la imagen puedo tratarla
            // Comprobamos que no se haya producido ningun error
            if let e = error {
                print("Error downloading image: \(e)")
            } else {
                // Tratamos la respuesta de la URL
                // Comprobamos el tipo de respuesta obtenida
                if let _ = response as? HTTPURLResponse {
                    // Tratamos el data obtenido de la URL
                    if let imageData = data {
                        // Convertimos la imagen del tipo data a una UIImage para poder enviarla en el completion
                        completion(UIImage(data: imageData)!)
                    } else {
                        print("Couldn't get image: Image is nil") // No se ha podido obtener el recurso
                    }
                } else {
                    print("Couldn't get response code for some reason") // El servidor no esta accesible
                }
            }}.resume()
    }
}
