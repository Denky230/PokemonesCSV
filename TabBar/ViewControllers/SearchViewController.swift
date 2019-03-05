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
        // Show / Hide category buttons drop-down menu
        filterButtons.forEach { $0.isHidden = !$0.isHidden }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    // [0] = Unknown Pokemons
    // [1] = Known Pokemons
    var displayPokemones: [[Pokemon]] = [ [Pokemon](), [Pokemon]() ]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initSearchBar()
        initFilterButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        displayPokemones[1] = loggedUser.pokedex
        displayPokemones[0] = unknownPokemons
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
            
            // Add button to filter buttons collection + parent view
            filterButtons.append(button)
            view.addSubview(button)
        }
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
            cell.captured.image = isPokemonCaptured ? CAPTURED_SPRITE : nil
        } else {
            cell.name.text = ""
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
        // Display Pokemons based on search
        displayPokemones[1] = searchText == "" ?
            pokemones : pokemones.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        
        tableView.reloadData()
    }
}
