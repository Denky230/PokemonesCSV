//
//  TableViewController.swift
//  TabBar
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokemones: [Pokemon] = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTableView()
        initPokemones()
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func initPokemones() {
        pokemones = [
            Pokemon(name: "Squirtle", type: .WATER),
            Pokemon(name: "Charmander", type: .FIRE),
            Pokemon(name: "Bulbasaur", type: .GRASS, subtype: .POISON),
            Pokemon(name: "Salamence", type: .DRAGON, subtype: .FLYING)
        ]
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemones.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create our custom ViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Initialize ViewController with selected Pokemon
        vc.pokemon = pokemones[indexPath.row]
        
        // Push custom ViewController 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create our custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! PokemonCell
        
        // Set up cell elements
        cell.imgView.image = pokemones[indexPath.row].sprite
        cell.lbl_name.text = pokemones[indexPath.row].name
        cell.lbl_type.text = pokemones[indexPath.row].type.rawValue
        cell.lbl_subtype.text = pokemones[indexPath.row].subtype.rawValue
        cell.isLiked.text = pokemones[indexPath.row].isLiked ? "Likey" : "No Likey"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = [UIContextualAction]()
        
        // TO DO: Add actions
        let action = UIContextualAction(style: .normal, title: "Like") { (action, view, completion) in self.pokemones[indexPath.row].isLiked = !self.pokemones[indexPath.row].isLiked
            tableView.reloadRows(at: [indexPath], with: .none)
            completion(true)
        }
        action.title = pokemones[indexPath.row].isLiked ? "Dislike" : "Like"
        action.backgroundColor = pokemones[indexPath.row].isLiked ? .gray : .cyan
        actions.append(action)
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}
