//
//  SortByOptions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

/// filter options for top-headlines
enum TopFilterOption: Hashable {
    
    /// ["country": country]
    /// search news from specific countries
    case country(Country)
    
    // ["category": category.rawValue]
    /// search news in specific categories
    case category(Category)
    
    /// "sources": source.id
    /// search news from specific Sources
    case source(Source)

    // ["q": text]
    /// search text in news using query, see docs
    case query(String)
    
    
    var queryItem: URLQueryItem {
        switch self {
        case .country(let country):
            return .init(name: "country",
                         value: country.rawValue)
        case .category(let category):
            return .init(name: "category",
                         value: category.rawValue)
        case .source(let source):
            return .init(name: "sources",
                         value: source.id)
        case .query(let text):
            return .init(name: "q",
                         value: text)
        }
    }
}
