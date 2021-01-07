//
//  SortByOptions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum FilterOption: Hashable {
    
    /// "sortBy": sortBy.paramString
    case sortBy(SortByOptions)
    
    /// "from": fromDate.paramString
    case fromDate(DateOptions)
    
    /// "to": toDate.paramString
    case toDate(DateOptions)
    
    
    //TODO: all below options are repeated in TopFilterOption, consider nesting it here
    
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
    
    // ["languages": language,
    // "sources": sourcesQueryString]
    /// 2nd arg is sourcesQueryString
    /// search news in specific languages
    case language(Language, String)
    
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .sortBy(let sortByOptions):
            return [
                URLQueryItem(name: "sortBy",
                             value: sortByOptions.rawValue)
            ]
        case .fromDate(let dateOptions):
            return [
                URLQueryItem(name: "from",
                             value: dateOptions.paramString)
            ]
        case .toDate(let dateOptions):
            return [
                URLQueryItem(name: "to",
                             value: dateOptions.paramString)
            ]
        case .source(let source):
            return [
                URLQueryItem(name: "sources",
                             value: source.id)
            ]
        case .query(let text):
            return [
                URLQueryItem(name: "q",
                             value: text)
            ]
        case .country(let country):
            return [
                URLQueryItem(name: "country",
                             value: country.rawValue)
            ]
        case .category(let category):
            return [
                URLQueryItem(name: "category",
                             value: category.rawValue)
            ]
        case .language(let language, let sourcesQueryString):
            let item1 = URLQueryItem(name: "sources",
                                     value: sourcesQueryString)
            let item2 = URLQueryItem(name: "languages",
                                     value: language.rawValue)
            return [item1, item2]
        }
    }
}
