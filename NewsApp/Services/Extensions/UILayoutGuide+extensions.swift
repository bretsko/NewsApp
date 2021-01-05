//
//  UILayoutGuide+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UILayoutGuide {
    
    func pinToEdgesEqually(view: UIView, inset: UIEdgeInsets = UIEdgeInsets.zero) -> [NSLayoutConstraint] { // pins view to edge - returns array of constraints that needs to be activated
        [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
        ]
    }
    
    func pinLeftAndRightEqually(view: UIView, sideInset: CGFloat) -> [NSLayoutConstraint] { // pins view to edge - returns array of constraints that needs to be activated
        [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideInset),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideInset),
            // no top or bottom constraint
            topAnchor.constraint(equalTo: view.topAnchor, constant: .zero),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero)
        ]
    }
    
    func pinTopAndBottomEqually(view: UIView, topAndBottomInset: CGFloat) -> [NSLayoutConstraint] { // pins view to edge - returns array of constraints that needs to be activated
        [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            // no top or bottom constraint
            topAnchor.constraint(equalTo: view.topAnchor, constant: topAndBottomInset),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: topAndBottomInset)
        ]
    }
}
