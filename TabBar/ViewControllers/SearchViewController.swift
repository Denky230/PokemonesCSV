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
    
    // Search bar
    @IBOutlet weak var searchBar: UISearchBar!
    // Filter drop-down menu
    var typesToFilter: [PokemonType] = [PokemonType]()
    var filterButtons: [UIButton] = [UIButton]()
    @IBOutlet weak var btnFilter: UIButton!
    @IBAction func dropFilterMenu(_ sender: UIButton) {
        // Show / Hide category buttons drop-down menu
        filterButtons.forEach { $0.isHidden = !$0.isHidden }
    }
    
    // Display Pokemons states
    let unknown = 0, known = 1
    var displayPokemones: [[Pokemon]] = [ [Pokemon](), [Pokemon]() ]
    var totalPokemones: [Pokemon] = [Pokemon]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
        initFilterButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        totalPokemones = pokemones
        displayPokemones[unknown] = unknownPokemons
        displayPokemones[known] = totalPokemones
        filterPokemons()
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
            button.tag = 0
            button.isHidden = true
            
            // Add onClick() event to button
            button.addTarget(self, action: #selector(filterPokemonType), for: .touchUpInside)
            
            // Add button to filter buttons collection + parent view
            filterButtons.append(button)
            view.addSubview(button)
        }
    }
    
    @objc func filterPokemonType(_ sender: UIButton) {
        if sender.tag == 0 {
            // Add type to filter
            typesToFilter.append(PokemonType(rawValue: sender.currentTitle!)!)
            sender.backgroundColor = .gray
            sender.tag = 1
        } else {
            // Remove type from filter
            typesToFilter.removeAll { $0.rawValue == sender.currentTitle }
            sender.backgroundColor = .white
            sender.tag = 0
        }
        
        filterPokemons()
    }
    func filterPokemons() {
        // Reset displayPokemones to recuperate previous filtered out ones
        displayPokemones[known] = totalPokemones
        
        // Filter Pokemons based on active filters
        displayPokemones[known] = typesToFilter.isEmpty ?
            displayPokemones[known] :
            displayPokemones[known]
                // Filter Pokemons with type or subtype active as filter
                .filter { p in typesToFilter.contains{ $0 == p.type || $0 == p.subtype }  }
                // Sort Pokemons by type + subtype selected >> type following filter order >> id
                .sorted(by: { p1, p2 in
                    let p1type = PokemonType.allCases.firstIndex(of: p1.type)!
                    let p2type = PokemonType.allCases.firstIndex(of: p2.type)!
                    let p1matchingTypes = typesToFilter.filter { $0 == p1.type || $0 == p1.subtype }.count
                    let p2matchingTypes = typesToFilter.filter { $0 == p2.type || $0 == p2.subtype }.count                    
                    if p1matchingTypes == p2matchingTypes {
                        if p1type == p2type {
                            return p1.id < p2.id
                        } else {
                            return p1type < p2type
                        }
                    } else {
                        return p1matchingTypes > p2matchingTypes
                    }
                })
        
        // Filter Pokemons based on search
        let searchText = searchBar.text!
        displayPokemones[known] = searchText == "" ?
            displayPokemones[known] :
            displayPokemones[known].filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
    }
    
    func scanPokemon(pokemon: Pokemon, indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Scan") { (action, view, completion) in
            // Remove Pokemon from unknown Pokemons
            unknownPokemons.removeAll { $0 == pokemon }
            // Add Pokemon to User pokedex
            loggedUser.pokedex.append(pokemon)
            // Go to Pokemon details screen
            self.checkPokemonDetails(pokemon: pokemon)
            completion(true)
        }
        action.image = UIImage(named: "question-mark_64x64")
        action.backgroundColor = .gray
        action.title = ""
        
        return action
    }
    func checkPokemonDetails(pokemon: Pokemon) {
        // Instantiate a PokemonDetailsViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Assign selected Pokemon
        vc.pokemon = pokemon
        
        // Go to PokemonDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayPokemones.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Unknown"
            case 1:
                return "Known"
            default:
                return ""
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayPokemones[section].count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchListCell") as! SearchListCell
        let pokemon = displayPokemones[indexPath.section][indexPath.row]
        
        // Set up cell elements
        cell.sprite.image = pokemon.sprite
        // Check if Pokemon is known
        if loggedUser.pokedex.contains(where: { $0 == pokemon }) {
            cell.name.text = pokemon.name
            let isPokemonCaptured: Bool = loggedUser.pokemons.contains { $0 == pokemon }
            cell.captured.isHidden = !isPokemonCaptured
        } else {
            cell.name.text = "\(pokemon.id) \(pokemon.type.rawValue) \(pokemon.subtype.rawValue)" // TEST - Set to ""
            // Tint Pokemon sprite black
            cell.sprite.image = cell.sprite.image?.withRenderingMode(.alwaysTemplate)
            cell.sprite.tintColor = .black
        }
        
        return cell
    }
    // OnClick --> Check selected Pokemon's details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkPokemonDetails(pokemon: displayPokemones[indexPath.section][indexPath.row])
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = [UIContextualAction]()
        let pokemon = displayPokemones[indexPath.section][indexPath.row]
        
        // Scan
        // Check if Pokemon is unknown (no use in scanning a scanned Pokemon)
        if !loggedUser.pokedex.contains(where: { $0 == pokemon }) {
            actions.append(scanPokemon(pokemon: pokemon, indexPath: indexPath))
        }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPokemons()
    }
}
