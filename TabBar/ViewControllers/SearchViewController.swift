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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var displayPokemones: [Pokemon] = PokeData.pokemones
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initTableView()
        initSearchBar()
    }
    
    func initTableView() {
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func initSearchBar() {
        searchBar.delegate = self
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
        cell.sprite.image = pokemon.sprite
        cell.name.text = pokemon.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = [UIContextualAction]()
        
        // TO DO: Add actions
//        let action = UIContextualAction(style: .normal, title: "Scan") { (action, view, completion) in self.displayPokemones[indexPath.row].isCaptured = !self.displayPokemones[indexPath.row].isCaptured
//            tableView.reloadRows(at: [indexPath], with: .none)
//            completion(true)
//        }
//        actions.append(action)
        
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
