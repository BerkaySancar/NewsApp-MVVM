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
    
    func fetchNews() {
        newsService.fetchNews { response in
            self.newList = response?.articles ?? []
            self.dataRefreshed?()
        } failure: { error in
            print(error)
            self.dataNotRefreshed?()
        }
    }
    
    func searchNews(_ text: String?) {

        if let text = text, text.count > 2 {
            newsService.searchNews(text: text) { response in
                self.newList = response?.articles ?? []
                self.dataRefreshed?()
            } failure: { error in
                print(error)
                self.dataNotRefreshed?()
            }
        }
    }
}
