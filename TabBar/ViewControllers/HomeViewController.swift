//
//  TableViewController.swift
//  TabBar
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTableView()
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Pokedex.pokemones.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create our custom ViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Initialize ViewController with selected Pokemon
        vc.pokemon = Pokedex.pokemones[indexPath.row]
        
        // Push custom ViewController 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create our custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell") as! DetailsCell
        
        // Set up cell elements
        cell.imgView.image = Pokedex.pokemones[indexPath.row].sprite
        cell.lbl_name.text = Pokedex.pokemones[indexPath.row].name
        cell.lbl_type.text = Pokedex.pokemones[indexPath.row].type.rawValue
        cell.lbl_subtype.text = Pokedex.pokemones[indexPath.row].subtype.rawValue
        cell.isLiked.text = Pokedex.pokemones[indexPath.row].isLiked ? "Likey" : "No Likey"
        
        return cell
    }
}
