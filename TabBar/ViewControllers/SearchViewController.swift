//
//  SearchTableViewController.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 19/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let CELL_HEIGHT: CGFloat = 120
    let CAPTURED_SPRITE: UIImage = UIImage(named: "home_unselected")!
    
    var displayPokemones: [Pokemon] = PokeData.pokemones
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func initSearchBar() {
        searchBar.delegate = self
    }
    
    func capturePokemon(pokemon: Pokemon, indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Capture") { (action, view, completion) in
            loggedUser.pokemons.append(pokemon)
            self.tableView.reloadRows(at: [indexPath], with: .none)
            completion(true)
        }
        action.title = "+"
        action.backgroundColor = .cyan
        
        return action
    }
    func releasePokemon(pokemon: Pokemon, indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Capture") { (action, view, completion) in
            loggedUser.pokemons.removeAll { $0.name == pokemon.name }
            self.tableView.reloadRows(at: [indexPath], with: .none)
            completion(true)
        }
        action.title = "X"
        action.backgroundColor = .gray
        
        return action
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayPokemones.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create our custom ViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Initialize ViewController with selected Pokemon
        vc.pokemon = displayPokemones[indexPath.row]
        
        // Push custom ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create our custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchListCell") as! SearchListCell
        
        // Set up cell elements
        let pokemon = displayPokemones[indexPath.row]
        cell.name.text = pokemon.name
        cell.sprite.image = pokemon.sprite
        let isPokemonCaptured: Bool = loggedUser.pokemons.contains { $0.name == pokemon.name }
        cell.isCaptured.image = isPokemonCaptured ? CAPTURED_SPRITE : nil
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = [UIContextualAction]()
        
        let pokemon = displayPokemones[indexPath.row]
        let isPokemonCaptured: Bool = loggedUser.pokemons.contains { $0.name == pokemon.name }
        
        if !isPokemonCaptured {
            actions.append(capturePokemon(pokemon: pokemon, indexPath: indexPath))
        } else {
            actions.append(releasePokemon(pokemon: pokemon, indexPath: indexPath))
        }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Display Pokemons based on search
        displayPokemones = searchText == "" ?
            PokeData.pokemones : PokeData.pokemones.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
    }
}
