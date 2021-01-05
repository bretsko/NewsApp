//
//  Source.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/25/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct Sources: Decodable {
    let status: String
    let sources: [Source]
    
    /// in case status is not ok
    let message: String?
}

struct ArticleSource: Decodable {
    let id: String?
    let name: String
}

struct Source: Decodable {
    
    /// identifier of news source
    let id: String
    
    /// name news source
    let name: String
    
    /// A description of the news source
    let description: String
    
    /// URL of the homepage.
    let url: URL
    
    /// type of news
    let category: String
    
    /// language news was written on
    let language: String
    
    /// country this news source is based in (and primarily writes about)
    let country: String
}
