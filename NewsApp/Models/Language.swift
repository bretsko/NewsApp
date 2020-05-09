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
    
    ///returns a string of sources that has the same language as passed language separated by a comma
    static public func getSourcesString(language: String, sources: [Source]) -> String {
        let filteredSourcesId = sources.filter { $0.language == language }.map { "\($0.id)" } //only get sources that have language == language passed, and create an array of source's id
        return filteredSourcesId.prefix(20).joined(separator: ",") //get the first 20 source id and join them by ","
    }
}

extension Language: CaseIterable { //to be able to use Category.allCases
}
