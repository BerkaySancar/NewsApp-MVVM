//
//  FavoritesViewModel.swift
//  NewsApp
//
//  Created by Berkay Sancar on 4.08.2022.
//

import Foundation

final class FavoritesViewModel {
    
    var favorites: [Article] = [] {
        didSet {
            saveFavorites()
        }
    }
    
    var dataRefreshed: (([Article]) -> Void)?
    var dataNotRefreshed: (() -> Void)?
    
    func getFavorites() {
        
        let defaults = UserDefaults.standard
        
        guard
            let data = defaults.data(forKey: "fav1"),
            let savedFavs = try? JSONDecoder().decode([Article].self, from: data) else { return }
        if savedFavs.isEmpty {
            self.dataNotRefreshed?()
        } 
        self.dataRefreshed?(savedFavs)
    }
    
    func saveFavorites() {
        let defaults = UserDefaults.standard
        if let encodedData = try? JSONEncoder().encode(favorites) {
            defaults.set(encodedData, forKey: "fav1")
        }
    }
}
