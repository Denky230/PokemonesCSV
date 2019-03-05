//
//  PokemonCell.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var sprite: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var subtype: UILabel!
    @IBOutlet weak var questionMark: UIImageView!
    
    @IBOutlet weak var btnCapture: UIButton!
    @IBAction func capture(_ sender: UIButton) {
        // Add Pokemon to User collection
        let selectedPokemon = pokemones.filter { $0.id == sender.tag }.first!
        loggedUser.pokemons.append(selectedPokemon)
        // Remove Pokemon from Home list
        homePokemons.removeAll { $0 == selectedPokemon }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
