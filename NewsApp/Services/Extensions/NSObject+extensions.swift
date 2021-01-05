//
//  NSObject+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 3/28/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// Used to quickly setup all views
    /// To use:
    /// let titleLabel = Init(value: UILabel()) {
    ///        $0.translatesAutoresizingMasksIntoConstraints = false
    ///        $0.text = “Hello World”
    ///    }
    ///  Source - https://medium.com/swlh/tips-for-creating-ui-programmatically-c41dbce09836
    static func Init<Type>(value: Type, block: (_ object: Type) -> ()) -> Type {
        block(value)
        return value
    }
}
