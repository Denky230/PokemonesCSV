//
//  MyTextField.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 07/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class MyTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStyle()
    }
    
    func setupStyle() {
        font                = Theme.Font.textField
        textAlignment       = .left
        borderStyle         = .bezel
        autocorrectionType  = .no
    }
}
