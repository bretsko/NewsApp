//
//  UITabBarController+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/22/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func isMainTabBar() {
        //        tabBar.layer.masksToBounds = true
        //        tabBar.layer.cornerRadius = 20
        //        tabBar.barStyle = .black

        //MARK: - Color customization

        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.barTintColor = SettingsService.shared.whiteColor // bar color
        tabBar.tintColor = SettingsService.shared.mainColor // selected tab
        tabBar.unselectedItemTintColor = .gray

        //MARK: - Tab Bar Size Customization

        //        let width = self.view.frame.width - 50
        //        var newFrame = tabBar.frame
        //        //        newFrame.size.height = 100
        //        //        newFrame.origin.y = view.frame.size.height - 100
        //        newFrame.size.width = width
        //        newFrame.origin.x = (view.frame.width - width) / 2 //centers it
        //        tabBar.frame = newFrame
    }
}
