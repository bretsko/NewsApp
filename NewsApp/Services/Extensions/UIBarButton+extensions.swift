//
//  UIBarButton+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/15/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    static func navButton(_ target: Any?, action: Selector, image: UIImage) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(image.withTintColor(.offWhite), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return menuBarItem
    }
}
