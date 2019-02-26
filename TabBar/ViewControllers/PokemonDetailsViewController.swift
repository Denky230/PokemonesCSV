//
//  PokemonDetailsViewController.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 22/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonSubType: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
    }
    
    func setUpViews() {
        pokemonImage.image = pokemon.sprite
        pokemonName.text = pokemon.name
        pokemonType.text = pokemon.type.rawValue
        pokemonSubType.text = pokemon.subtype.rawValue
        pokemonDescription.text = pokemon.description
    }
}
