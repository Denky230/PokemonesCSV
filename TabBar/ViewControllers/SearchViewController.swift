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
    
    var filterButtons: [UIButton] = [UIButton]()
    @IBOutlet weak var btnFilter: UIButton!
    @IBAction func dropFilterMenu(_ sender: UIButton) {
        filterButtons.forEach { $0.isHidden = !$0.isHidden }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    var displayPokemones: [Pokemon] = [Pokemon]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
        initFilterButtons()
        displayPokemones = pokemones
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
    func initFilterButtons() {
        // Get filter button's frame to use as reference
        let frame: CGRect = btnFilter.frame
        for (index, element) in PokemonType.allCases.enumerated() {
            // Create custom UIButton for each Pokemon type
            let w: CGFloat = 150
            let h: CGFloat = 50
            let button: UIButton = UIButton(frame: CGRect(
                x: frame.maxX - w,
                y: frame.maxY + (h * CGFloat(index)), // Set each button <frame.height> lower
                width: w,
                height: h
            ))
            // Add style to button
            // Set button title to type name
            button.setTitle(element.rawValue, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 1
            button.isHidden = true
            
            // Add button to filter buttons + parent view
            filterButtons.append(button)
            view.addSubview(button)
        }
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
            pokemones : pokemones.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
    }
}
