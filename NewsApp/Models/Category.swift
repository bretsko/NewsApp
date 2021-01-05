//
//  Category.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum Category: String, CaseIterable {
    
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    var image: UIImage {
        UIImage(named: "\(String(describing: self)).jpg")!
    }
}

