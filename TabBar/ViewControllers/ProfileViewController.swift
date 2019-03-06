//
//  ProfileViewController.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 26/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let ITEMS_PER_ROW: CGFloat = 3
    let ITEM_MARGIN: CGFloat = 5.0
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pokemon: UIImageView!
    @IBOutlet weak var pokemonCounter: UILabel!
    @IBOutlet weak var pokeballCounter: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        
        // Tint Pikachu icon black
        pokemon.image = pokemon.image?.withRenderingMode(.alwaysTemplate)
        pokemon.tintColor = .black
    }
    override func viewWillAppear(_ animated: Bool) {
        // Make sure User data is up-to-date
        image.image = loggedUser.image == nil ?
            UIImage(named: "profile_unselected") : loggedUser.image
        name.text = loggedUser.name
        pokemonCounter.text = "\(loggedUser.pokemons.count)"
        pokeballCounter.text = "\(loggedUser.pokeballs)"
        
        collectionView.reloadData()
    }
    
    func initCollectionView() {
        // Black magic to make the CollectionView look good
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let size = (collectionView.frame.width / ITEMS_PER_ROW) - ITEM_MARGIN
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumInteritemSpacing = ITEM_MARGIN
        layout.minimumLineSpacing = ITEM_MARGIN
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loggedUser.pokemons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create custom cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        
        // Set cell elements
        cell.sprite.image = loggedUser.pokemons[indexPath.item].sprite
        
        return cell
    }
    // OnClick --> Check selected Pokemon's details
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Instantiate a PokemonDetailsViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Assign selected Pokemon
        vc.pokemon = loggedUser.pokemons[indexPath.item]
        
        // Go to PokemonDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
