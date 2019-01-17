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
            Pokemon(name: "Squirtle", type: "Water"),
            Pokemon(name: "Charmander", type: "Fire"),
            Pokemon(name: "Bulbasaur", type: "Grass", subtype: "Poison"),
            Pokemon(name: "Salamence", type: "Dragon", subtype: "Flying")
        ]
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemones.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create our custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! PokemonCell
        
        // Set up cell elements
        cell.imgView.image = pokemones[indexPath.row].sprite
        cell.lbl_name.text = pokemones[indexPath.row].name
        cell.lbl_type.text = pokemones[indexPath.row].type
        cell.lbl_subtype.text = pokemones[indexPath.row].subtype
        
        return cell
    }
}
