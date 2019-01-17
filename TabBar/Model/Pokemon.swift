//
//  Pokemon.swift
//  TabBar
//
//  Created by dmorenoar on 17/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class Pokemon {
    
    let sprite: UIImage
    let name: String
    let type: String
    private var _subtype: String!
    var subtype: String {
        get {
            if let sub = self._subtype {
                return sub
            } else {
                return ""
            }
        }
        set(newValue) {
            self._subtype = newValue
        }
    }
    var description: String!
    
    init(sprite: UIImage, name: String, type: String) {
        self.sprite = sprite
        self.name = name
        self.type = type
    }
    
    // TEST - Remove when every Pokemon has its own sprite
    convenience init(name: String, type: String) {
        self.init(sprite: UIImage(named: "pokemon")!, name: name, type: type)
    }
    
    convenience init(name: String, type: String, subtype: String) {
        self.init(name: name, type: type)
        self.subtype = subtype
    }
}
