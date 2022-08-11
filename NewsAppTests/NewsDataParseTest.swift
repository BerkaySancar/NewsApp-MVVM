//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Berkay Sancar on 24.07.2022.
//

@testable import NewsApp
import XCTest

class NewsDataParseTest: XCTestCase {
    
    func testSuccessParser() {
        
        let json = """
                {
                "articles": [
                {
                    "source": {
                        "id": null,
                        "name": "name"
                    },
                    "author": "author",
                    "title": "title",
                    "description": "description",
                    "url": "url",
                    "urlToImage": "urltoimage",
                    "publishedAt": "published",
                    "content": "content"
                }
                ]
                }
                """.data(using: .utf8)!
        
        let news = try! JSONDecoder().decode(Article.self, from: json)

        XCTAssertNotNil(news)
    }
}
