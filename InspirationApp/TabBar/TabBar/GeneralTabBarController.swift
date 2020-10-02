//
//  GeneralTabBarController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/25/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit

class GeneralTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let feedViewController: UINavigationController = UINavigationController.init(rootViewController: FeedViewController())
        feedViewController.tabBarItem = UITabBarItem.init(tabBarSystemItem: UITabBarItem.SystemItem.mostViewed, tag: 1)
        
        let searchViewController: UINavigationController = UINavigationController.init(rootViewController: SearchViewController())
        searchViewController.tabBarItem = UITabBarItem.init(tabBarSystemItem: UITabBarItem.SystemItem.search, tag: 2)
        
        let favouritesViewController: UINavigationController = UINavigationController.init(rootViewController: SavedViewController())
        favouritesViewController.tabBarItem = UITabBarItem.init(tabBarSystemItem: UITabBarItem.SystemItem.favorites, tag: 3)
        
        self.viewControllers = [feedViewController, searchViewController, favouritesViewController]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
