//
//  ProfileViewController.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 26/02/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        print(loggedUser.pokemons.count)
        print(collectionView.numberOfItems(inSection: 0))
    }
    
    func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loggedUser.pokemons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create our custom cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        
        // Set cell elements
        cell.sprite.image = loggedUser.pokemons[indexPath.row].sprite
        
        return cell
    }
}
