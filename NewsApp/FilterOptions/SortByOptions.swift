//
//  SortByOptions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit


//The order to sort the articles in request https://newsapi.org/docs/endpoints/everything.
enum SortByOptions: String, CaseIterable {
    
    //newest articles come first.
    case publishedAt
    
    /// articles more closely related to q come first.
    case relevancy
    
    //articles from popular sources and publishers come first.
    case popularity
    
    var paramString: String {
        rawValue
    }
}
