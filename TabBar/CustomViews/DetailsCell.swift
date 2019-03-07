//
//  PokemonCell.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var sprite: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var subtype: UILabel!
    @IBOutlet weak var questionMark: UIImageView!
    @IBOutlet weak var btnCapture: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
