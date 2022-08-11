//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Berkay Sancar on 26.07.2022.
//

import Foundation

final class HomeViewModel {
   
    var newList: [Article] = []
    var newsService = NewsService()

    var dataRefreshed: (() -> Void)?
    var dataNotRefreshed: (() -> Void)?

// MARK: - GET DATA
    func fetchSearchAndFilterNews(text: String?, from: String, to: String) {
        
        if let text = text, text.count > 2 {
            newsService.searchAndFilterNews(text: text, from: from, to: to) { response in
                self.newList = response?.articles ?? []
                self.dataRefreshed?()
            } failure: { error in
                print(error)
                self.dataNotRefreshed?()
            }
        }
    }
}
