//
//  TabBarController.swift
//  TabBar
//
//  Created by Oscar Rossello on 08/01/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let tabs: [String] = [
        "profile", "home", "search"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTabBarItems()
    }
    
    func initTabBarItems() {
        // Set up tabs
        for i in 0 ..< tabBar.items!.count {
            tabBarItem = tabBar.items![i]
            
            // Set Unselected image
            tabBarItem.image =
                UIImage(named: tabs[i] + "_unselected")?.withRenderingMode(.alwaysOriginal)
            // Set Selected image
            tabBarItem.selectedImage =
                UIImage(named: tabs[i] + "_selected")?.withRenderingMode(.alwaysOriginal)
            
            // Set insets
            let tabBarHeight: CGFloat = tabBar.frame.height
            let yInset: CGFloat = (tabBarHeight / 2)
            tabBarItem.imageInsets = UIEdgeInsets(
                top: yInset,
                left: 0,
                bottom: -yInset,
                right: 0
            )
        }
        // Set Home as the default tab
        selectedIndex = 1
    }
}
