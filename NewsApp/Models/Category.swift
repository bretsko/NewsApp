//
//  Category.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum Category: String {
    case business = "Business", entertainment = "Entertainment", general = "General", health = "Health", science = "Science", sports = "Sports", technology = "Technology"
    var image: UIImage {
        return UIImage(named: "\(String(describing: self)).jpg")!
    }
}

extension Category: CaseIterable { //to be able to use Category.allCases
}
