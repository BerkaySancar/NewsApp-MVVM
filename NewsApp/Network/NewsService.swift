//
//  NewsService.swift
//  NewsApp
//
//  Created by Berkay Sancar on 1.08.2022.
//

import Alamofire

protocol ServiceProtocol {
    
    func searchAndFilterNews(text: String,
                             to: String,
                             success: @escaping (BaseResponse?) -> Void,
                             failure: @escaping (AFError) -> Void)
}

final class NewsService: ServiceProtocol {
    
    func searchAndFilterNews(text: String,
                             to: String,
                             success: @escaping (BaseResponse?) -> Void,
                             failure: @escaping (AFError) -> Void) {
        ServiceManager.shared.sendRequest(url: "\(Constants.BASE_URL)q=\(text)&from=2022-08-10&to=\(to)\(Constants.LANGUAGE + Constants.API_KEY3)") { (response: BaseResponse) in
            success(response)
        } failure: { error in
            failure(error)
        }
    }
}
