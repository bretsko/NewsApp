//
//  UIView+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/14/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIView {
    
/// Constraint view to its superview
    func fitInSuperview() {
        guard let sv = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: sv.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor).isActive = true
    }
    
/// Constraint view to its superview's margin
    func fitInSuperviewMargins() {
        guard let sv = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: sv.topAnchor, constant: sv.layoutMargins.top).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor,constant: -sv.layoutMargins.bottom).isActive = true
        leftAnchor.constraint(equalTo: sv.leftAnchor,constant: sv.layoutMargins.left).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor,constant: -sv.layoutMargins.right).isActive = true
    }

/// Returns a collection of constraints to anchor the bounds of the current view to the given view.
/// https://medium.com/better-programming/auto-layout-in-swift-ffd918d4ec06
/// - Parameter view: The view to anchor to.
/// - Returns: The layout constraints needed for this constraint.
    func pinEdgesEquallyTo(boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
    
/// Constraint a view to another view with equal leading and trailing helper
    func pinLeftAndRightEdgesEquallyTo(constantInset: CGFloat = 0.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constantInset),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -constantInset)
        ]
    }
    
/// Top and bottom constraint helper
    func pinTopAndBottomEdgesEquallyTo(constantInset: CGFloat = 0.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: constantInset),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constantInset),
            trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }
    
/// Height constraint helper
    func pinHeightTo(constantInset: CGFloat = 0.0, multiplier: CGFloat = 1.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        if constantInset != 0.0 && multiplier != 1.0 {
            print("Height cannot apply both constant inset and multiplier at the same time")
            return []
        }
        if constantInset == 0.0 { //apply constant to height
            return [
               heightAnchor.constraint(equalTo: view.heightAnchor, constant: constantInset)
            ]
        } else { //apply multiplier to height
            return [
                heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
            ]
        }
    }
    
    func pinWidthTo(constantInset: CGFloat = 0.0, multiplier: CGFloat = 1.0, boundsOf view: UIView) -> [NSLayoutConstraint] {
        if constantInset != 0.0 && multiplier != 1.0 {
            print("Width cannot apply both constant inset and multiplier at the same time")
            return []
        }
        if constantInset == 0.0 { //apply constant to height
            return [
               widthAnchor.constraint(equalTo: view.widthAnchor, constant: constantInset)
            ]
        } else { //apply multiplier to height
            return [
                widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
            ]
        }
    }
}
//extension NSLayoutConstraint {
//
//    /// Returns the constraint sender with the passed priority.
//    /// https://medium.com/better-programming/auto-layout-in-swift-ffd918d4ec06
//    /// - Parameter priority: The priority to be set.
//    /// - Returns: The sended constraint adjusted with the new priority.
//    func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
//        self.priority = priority
//        return self
//    }
//
//}
//
//extension UILayoutPriority {
//
//    /// Creates a priority which is almost required, but not 100%.
//    static var almostRequired: UILayoutPriority {
//        return UILayoutPriority(rawValue: 999)
//    }
//
//    /// Creates a priority which is not required at all.
//    static var notRequired: UILayoutPriority {
//        return UILayoutPriority(rawValue: 0)
//    }
//}
