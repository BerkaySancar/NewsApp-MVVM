//
//  NewsModel.swift
//  NewsApp
//
//  Created by Berkay Sancar on 1.08.2022.
//

import Foundation

struct BaseResponse: Codable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
