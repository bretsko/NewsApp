//
//  UIStackView+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 3/28/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIStackView {
    
    /// setup vertical stackView
    func setupStandardVertical() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fill
        axis = .vertical
        alignment = .fill
    }
    
    /// setup horizontail stackView
    func setupStandardHorizontal() {
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fill
        axis = .horizontal
        alignment = .fill
    }
}
