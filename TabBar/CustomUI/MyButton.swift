//
//  MyButton.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 07/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class MyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStyle()
    }
    
    func setupStyle() {
        setTitleColor(Theme.Color.font, for: .normal)
        
        setBackgroundColor(color: Theme.Color.main, forState: .normal)
        setBackgroundColor(color: Theme.Color.secondary, forState: .highlighted)
        
        layer.borderWidth   = 0.4
        layer.borderColor   = Theme.Color.border.cgColor
        layer.cornerRadius  = frame.height / 4
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // Keep corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // Set background color forState
            setBackgroundImage(colorImage, for: forState)
        }
    }
}
