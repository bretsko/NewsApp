//
//  SortByOptions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum SortByOptions: String, CaseIterable {
    
    /// newest articles come first
    case publishedAt = "Newest"
    
    /// articles more closely related to q come first.
    case relevancy = "Relevancy"
    
    /// articles from popular sources and publishers come first.
    case popularity = "Popularity"
    
    // ??
    var paramString: String {
        switch self {
        case .publishedAt:
            return "publishedAt"
        case .relevancy:
            return "relevancy"
        case .popularity:
            return "popularity"
        }
    }
}
