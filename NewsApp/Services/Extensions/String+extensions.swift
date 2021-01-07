//
//  String+extensions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
        prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }
    
    func lowerCasingFirstLetter() -> String {
        prefix(1).lowercased() + dropFirst()
    }
    
    mutating func lowerCaseFirstLetter() {
        self = lowerCasingFirstLetter()
    }
}
