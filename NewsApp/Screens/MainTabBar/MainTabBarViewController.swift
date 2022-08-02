//
//  MainTabBarViewController.swift
//  NewsApp
//
//  Created by Berkay Sancar on 24.07.2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    private let homeViewController = UINavigationController(rootViewController: HomeViewController())
    private let favoritesViewController = UINavigationController(rootViewController: FavoritesViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
// MARK: - UI Configure
    private func configure() {
        homeViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        favoritesViewController.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        homeViewController.title = "Home".localized()
        favoritesViewController.title = "Favorites".localized()
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        setViewControllers([homeViewController, favoritesViewController], animated: true)
    }
}
