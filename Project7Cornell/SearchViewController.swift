//
//  SearchViewController.swift
//  p7
//
//  Created by Monica Ong on 2/20/18.
//  Copyright © 2018 CS 1998. All rights reserved.
//

import UIKit

class SearchTabBarController: UITabBarController {
    //p7

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = true
        let titleSearchVC = UINavigationController(rootViewController: TitleSearchVC())
        let ingredientsSearchVC = UINavigationController(rootViewController: IngredientsSearchVC())
        titleSearchVC.tabBarItem.title = "Title"
        ingredientsSearchVC.tabBarItem.title = "Ingredients"
        viewControllers = [titleSearchVC,ingredientsSearchVC]
    }
    
    
}

