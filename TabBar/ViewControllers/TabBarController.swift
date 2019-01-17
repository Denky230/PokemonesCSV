//
//  TabBarController.swift
//  TabBar
//
//  Created by Oscar Rossello on 08/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let spriteNames: [String] = [
        "bomb", "panda"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initTabBarItems()
    }
    
    func initTabBarItems() {
        for i in 0 ..< tabBar.items!.count {
            tabBarItem = tabBar.items![i]
            
            // Set Unselected image
            tabBarItem.image =
                UIImage(named: spriteNames[i] + "Unselected")?.withRenderingMode(.alwaysOriginal)
            // Set Selected image
            tabBarItem.selectedImage =
                UIImage(named: spriteNames[i] + "Selected")?.withRenderingMode(.alwaysOriginal)
            
            // Set insets
            let tabBarHeight: CGFloat = tabBar.frame.height
            let YInset: CGFloat = (tabBarHeight / 2)
            tabBarItem.imageInsets = UIEdgeInsets(
                top: YInset,
                left: 0,
                bottom: -YInset,
                right: 0
            )
        }
    }
}
