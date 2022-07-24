//
//  MainTabBarViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    private let homeViewController: UINavigationController = UINavigationController(rootViewController: HomeViewController())
    private let favouritesViewController: UINavigationController = UINavigationController(rootViewController: FavouritesViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        homeViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        favouritesViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        homeViewController.title = "Home"
        favouritesViewController.title = "Favourites"
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        setViewControllers([homeViewController, favouritesViewController], animated: true)
    }
}
