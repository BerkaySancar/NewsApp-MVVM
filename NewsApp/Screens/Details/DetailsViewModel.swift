//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Berkay Sancar on 3.08.2022.
//

import Foundation

struct DetailsViewModel {
 
    var news: Article?
    var dataRefreshed: ((Article?) -> Void)?
    var dataNotRefreshed: (() -> Void)?
    var favorites: [Article] = [] {
        didSet {
            saveFavorites()
        }
    }
 
    mutating func setNews(_ data: Article?) {
        if let model = data {
            self.news = model
            self.dataRefreshed?(model)
        } else {
            self.dataNotRefreshed?()
        }
    }
    
    mutating func addFavorites() {
        
        self.favorites.append(news!)
    }
    mutating func saveFavorites() {
         
        let defaults = UserDefaults.standard
        if let encodedData = try? JSONEncoder().encode(favorites) {
            defaults.set(encodedData, forKey: "fav1")
        }
    }
    mutating func getFavorites() {
        
        let defaults = UserDefaults.standard
        
        guard
            let data = defaults.data(forKey: "fav1"),
            let savedFavs = try? JSONDecoder().decode([Article].self, from: data) else { return }
        
        self.favorites = savedFavs
    }
}
