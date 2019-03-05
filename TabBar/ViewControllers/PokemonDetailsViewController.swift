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
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var subtype: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var questionMark: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        image.image = pokemon.sprite
        // Check if Pokemon is known
        if loggedUser.pokedex.contains(where: { $0 == pokemon }) {
            name.text = pokemon.name
            type.text = pokemon.type.rawValue
            subtype.text = pokemon.subtype.rawValue
            descr.text = pokemon.description
            descr.sizeToFit()
            questionMark.isHidden = true
        } else {
            // Tint Pokemon image black
            image.image = image.image?.withRenderingMode(.alwaysTemplate)
            image.tintColor = .black
            questionMark.isHidden = false
        }
    }
}
