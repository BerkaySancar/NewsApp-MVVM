//
//  NewsService.swift
//  NewsApp
//
//  Created by Berkay Sancar on 1.08.2022.
//

import Alamofire

protocol ServiceProtocol {
    
    func fetchNews(success: @escaping (BaseResponse?) -> Void, failure: @escaping (AFError) -> Void)
}

final class NewsService: ServiceProtocol {
    
    func fetchNews(success: @escaping (BaseResponse?) -> Void, failure: @escaping (AFError) -> Void) {
        ServiceManager.shared.sendRequest(url: "\(Constants.BASE_URL + Constants.API_KEY)") {(response: BaseResponse) in
            success(response)
        } failure: { error in
            failure(error)
        }
    }
}
