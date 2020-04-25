//
//  Category.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum Category: String {
    case business = "Business", entertainment = "Entertainment", general = "General", health = "Health", science = "Science", sports = "Sports", technology = "Technology"
}

extension Category: CaseIterable { //to be able to use Category.allCases
}
