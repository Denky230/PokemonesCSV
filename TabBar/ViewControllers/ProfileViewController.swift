//
//  ProfileViewController.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 26/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let ITEMS_PER_ROW: CGFloat  = 3
    let ITEM_MARGIN: CGFloat    = 5.0
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pokemon: UIImageView!
    @IBOutlet weak var pokemonCounter: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        // Make sure User data is up-to-date
        name.text = loggedUser.name
        image.image = loggedUser.image == nil ?
            UIImage(named: "profile_unselected") : loggedUser.image
        pokemonCounter.text = "\(loggedUser.pokemons.count)"        
        collectionView.reloadData()
    }
    
    func initCollectionView() {
        // Black magic to make the CollectionView look good
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let size = (collectionView.frame.width / ITEMS_PER_ROW) - ITEM_MARGIN
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing       = ITEM_MARGIN
        layout.minimumInteritemSpacing  = ITEM_MARGIN
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
        // Check selected Pokemon details in PokemonDetailsVC
        let selectedPokemon = loggedUser.pokemons[indexPath.row]
        manager.checkPokemonDetails(context: self, pokemon: selectedPokemon)
    }
}
