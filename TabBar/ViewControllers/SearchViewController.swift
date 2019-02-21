//
//  SearchTableViewController.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 19/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var displayPokemones: [Pokemon] = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initTableView()
        initSearchBar()
        displayPokemones = Pokedex.pokemones
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
        return 120
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
        cell.sprite.image = displayPokemones[indexPath.row].sprite
        cell.name.text = displayPokemones[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = [UIContextualAction]()
        
        // TO DO: Add actions
        let action = UIContextualAction(style: .normal, title: "Like") { (action, view, completion) in self.displayPokemones[indexPath.row].isLiked = !self.displayPokemones[indexPath.row].isLiked
            tableView.reloadRows(at: [indexPath], with: .none)
            completion(true)
        }
        action.title = displayPokemones[indexPath.row].isLiked ? "Dislike" : "Like"
        action.backgroundColor = displayPokemones[indexPath.row].isLiked ? .gray : .cyan
        actions.append(action)
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Display Pokemons based on search
        displayPokemones = searchText == "" ?
            Pokedex.pokemones : Pokedex.pokemones.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
    }
}
