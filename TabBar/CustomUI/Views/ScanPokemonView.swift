//
//  ScanPokemonView.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 09/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class ScanPokemonViewController: UIViewController {
    
    let CELL_HEIGHT: CGFloat = 120
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        navigationItem.title = "Scan Pokemon"
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func scanPokemon(pokemon: Pokemon, indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Scan") { (action, view, completion) in
            // Remove Pokemon from unknown Pokemons
            unknownPokemons.removeAll { $0 == pokemon }
            // Add Pokemon to User pokedex
            loggedUser.pokedex.append(pokemon)
            // Go to Pokemon details screen
            manager.checkPokemonDetails(context: self, pokemon: pokemon)
        }
        action.image = UIImage(named: "question-mark_64x64")
        action.backgroundColor = .gray
        action.title = ""
        
        return action
    }
}

extension ScanPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unknownPokemons.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "scanCell") as! SearchListCell
        let pokemon = unknownPokemons[indexPath.row]
        
        // Set up cell elements
        cell.sprite.image = pokemon.sprite
        // Tint Pokemon sprite black
        cell.sprite.image = cell.sprite.image?.withRenderingMode(.alwaysTemplate)
        cell.sprite.tintColor = .black
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = [UIContextualAction]()
        let pokemon = unknownPokemons[indexPath.row]
        
        // Scan Pokemon action
        actions.append(scanPokemon(pokemon: pokemon, indexPath: indexPath))
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}
