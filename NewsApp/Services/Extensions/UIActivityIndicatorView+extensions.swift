//
//  UIActivityIndicatorView+extensions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/28/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    
    /// function that animates and show indicatorView or not
    func shouldAnimate(shouldAnimate: Bool = true) {
        if shouldAnimate {
            startAnimating()
            isHidden = false
        } else {
            stopAnimating()
            isHidden = true
        }
    }
}
