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
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fill
        self.axis = .vertical
        self.alignment = .fill
    }
    
/// setup horizontail stackView
    func setupStandardHorizontal() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .fill
        self.axis = .horizontal
        self.alignment = .fill
    }
}
