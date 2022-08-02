//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Berkay Sancar on 26.07.2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {

    func dataRefreshed()
}

final class HomeViewModel {
   
    var newList: [Article] = []
    var newsService = NewsService()
    var delegate: HomeViewModelDelegate?
    
    func fetchData() {
        
        newsService.fetchNews { response in
            self.newList = response?.articles ?? []
            self.delegate?.dataRefreshed()
        } failure: { error in
            print(error)
        }
    }
}
