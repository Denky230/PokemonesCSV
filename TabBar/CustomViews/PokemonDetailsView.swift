//
//  PokemonDetailsView.swift
//  PokemonesCSV
//
//  Created by Oscar Rossello on 22/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class PokemonDetailsView: UIView {
    
    var pokemon: Pokemon
    
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame)
        setupViews()
    }
    /*
    convenience init(frame: CGRect, pokemon: Pokemon) {
        //self.pokemon = pokemon
        super.init(frame: frame)
        setupViews()
    }*/
    
    required init?(coder aDecoder: NSCoder) {
        self.pokemon = Pokemon(name: "", type: "")
        super.init(coder: aDecoder)
    }
    
    
    var labelAtaque:UILabel = {
        let lbl:UILabel = UILabel(frame: CGRect(x: 160, y: 50, width: 50, height: 50))
        lbl.text = String(99)
        lbl.textColor = UIColor.black
        return lbl
    }()
    
    
    func setupViews(){
        self.addSubview(statsView)
        statsView.addSubview(labelAtaque)
        
    }
    
    
    var statsView: UIView = {
        let view = UIView(frame: CGRect(x: -10, y: 0, width: 400, height: 200))
        
        view.backgroundColor = UIColor.green
        
        let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        //imageView.image = UIImage(named: "back_heroe")
        
        //view.addSubview(imageView)
        
        return view
    }()
    
    
    
    convenience init(frame:CGRect, pokemon:Pokemon) {
        self.init(frame: frame)
        //self.ataqueView = ataque
        setData(ataque: pokemon.name)
    }
    
    func setData(ataque:String){
        labelAtaque.text = ataque
    }
    
}
