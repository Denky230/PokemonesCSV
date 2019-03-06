//
//  TableViewController.swift
//  TabBar
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let POKEMON_PER_ZONE = 5
    let CELL_HEIGHT: CGFloat = 500
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullRandomPokemons()
        initTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func pullRandomPokemons() {
        // Get POKEMON_PER_ZONE random Pokemons
        for _ in 0 ..< POKEMON_PER_ZONE {
            var pokemon: Pokemon
            // Make sure Pokemon is valid for display
            repeat {
                pokemon = pokemones[Int.random(in: 0 ..< pokemones.count)]
            } while !isPokemonValid(pokemon: pokemon)
            
            // If Pokemon is unknown, store it for later display
            if !loggedUser.pokedex.contains(where: { $0 == pokemon }) {
                unknownPokemons.append(pokemon)
            }
            homePokemons.append(pokemon)
        }
        tableView.reloadData()
    }
    func isPokemonValid(pokemon: Pokemon) -> Bool {
        // Pokemon validation requisites
        let isPokemonRepeated = homePokemons.contains { $0 == pokemon }
        let isPokemonCaptured = loggedUser.pokemons.contains { $0 == pokemon }
        
        if isPokemonRepeated || isPokemonCaptured {
            return false
        }
        return true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePokemons.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create our custom ViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Initialize ViewController with selected Pokemon
        vc.pokemon = homePokemons[indexPath.row]
        
        // Push custom ViewController 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell") as! DetailsCell
        let pokemon = homePokemons[indexPath.row]
        
        // Set up cell elements
        cell.sprite.image = pokemon.sprite
        // Check if User has scanned Pokemon
        if loggedUser.pokedex.contains(where: { $0 == pokemon }) {
            cell.name.text = pokemon.name
            cell.type.text = pokemon.type.rawValue 
            cell.subtype.text = pokemon.subtype.rawValue
            cell.btnCapture.isHidden = false
            cell.btnCapture.tag = pokemon.id
            cell.questionMark.isHidden = true
        } else {
            // Tint Pokemon sprite black
            cell.sprite.image = cell.sprite.image?.withRenderingMode(.alwaysTemplate)
            cell.sprite.tintColor = .black
            // Pokemons can only be captured when scanned
            cell.btnCapture.isHidden = true
            // Show big question mark instead of Pokemon data
            cell.questionMark.isHidden = false
        }
        
        return cell
    }
}
