//
//  Language.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

enum Language: String {
    case ar = "Arabic", de = "German", en = "English", es = "Spanish", fr = "French", he = "Hebrew", it = "Italian", nl = "Dutch", no = "Norwegian", pt = "Portugal", ru = "Russian", se = "Northern Sami", zh = "Chinese"
}

extension Language: CaseIterable { //to be able to use Category.allCases
}
