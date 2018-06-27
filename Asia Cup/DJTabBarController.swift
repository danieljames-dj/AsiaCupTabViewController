//
//  DJTabBarController.swift
//  Asia Cup
//
//  Created by Daniel James on 27/06/18.
//  Copyright © 2018 Daniel James. All rights reserved.
//

import Foundation
import UIKit

class DJTabBarController: UITabBarController {
    
    var tabs: [DJTableViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabBarViewControllers: [UINavigationController] = []
        var tabBarItems: [UITabBarItem] = []
        var tabBarTitles = ["India", "Bangladesh", "Sri Lanka", "Pakistan"]
        
        for i in 0..<4 {
            tabs.append(DJTableViewController(id: i))
            tabs[i].navigationItem.title = tabBarTitles[i]
            tabBarViewControllers.append(UINavigationController(rootViewController: tabs[i]))
            if #available(iOS 11.0, *) {
                tabBarViewControllers[i].navigationBar.prefersLargeTitles = true
            }
            tabBarItems.append(UITabBarItem(title: tabBarTitles[i], image: nil, selectedImage: nil))
            tabBarViewControllers[i].tabBarItem = tabBarItems[i]
            if #available(iOS 11.0, *) {
                tabBarViewControllers[i].navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 29, weight: UIFont.Weight.bold)]
            }
        }
        self.viewControllers = tabBarViewControllers
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}
