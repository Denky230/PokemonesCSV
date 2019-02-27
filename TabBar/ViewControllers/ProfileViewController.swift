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
    
    @IBOutlet weak var imgUserimage: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPokeballs: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        // Make sure User data is up-to-date
        imgUserimage.image = loggedUser.image
        lblUsername.text = loggedUser.name
        lblPokeballs.text = "Pokeballs: \(loggedUser.pokeballs)"
        
        collectionView.reloadData()
    }
    
    func initCollectionView() {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        
        // Set cell elements
        cell.sprite.image = loggedUser.pokemons[indexPath.item].sprite
        cell.backgroundColor = .black
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Create our custom ViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemonDetailsVC") as! PokemonDetailsViewController
        
        // Initialize ViewController with selected Pokemon
        vc.pokemon = loggedUser.pokemons[indexPath.item]
        
        // Push custom ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
