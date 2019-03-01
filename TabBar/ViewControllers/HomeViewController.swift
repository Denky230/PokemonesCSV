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
        AppManager.loadPokemons()
        initTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell") as! DetailsCell
        
        // Set up cell elements
        cell.imgView.image = pokemones[indexPath.row].sprite
        cell.lbl_name.text = pokemones[indexPath.row].name
        cell.lbl_type.text = pokemones[indexPath.row].type.rawValue
        cell.lbl_subtype.text = pokemones[indexPath.row].subtype.rawValue
        
        return cell
    }
}
