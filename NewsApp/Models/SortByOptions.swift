//
//  SortByOptions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum SortByOptions: String {
    case publishedAt = "Newest", //newest articles come first.
    relevancy = "Relevancy", //articles more closely related to q come first.
    popularity = "Popularity" //articles from popular sources and publishers come first.
    
    var asSortByParameter: String {
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

extension SortByOptions: CaseIterable { //to be able to use Category.allCases
}
