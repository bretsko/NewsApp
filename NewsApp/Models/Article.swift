//
//  Article.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct ArticleList: Decodable {
    
    /// "ok" or error
    let status: String?
    
    /// code and message will have value if status is error
    let code: String?
    
    /// if status is error
    let message: String?
    
    /// number of articles, if status is ok
    let totalResults: Int?
    
    let articles: [Article]?
}


struct Article: Decodable, Hashable {
    
    let source: ArticleSource
    let author: String?
    let title: String
    let description: String?
    let publishedAt: String?
    
    let content: String?
    
    let url: URL?
    let urlToImage: URL?
    
    
    //MARK: -
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.title == rhs.title && lhs.url == rhs.url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title.hashValue)
    }
}
