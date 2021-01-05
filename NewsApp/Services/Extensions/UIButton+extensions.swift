//
//  UIButton+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/6/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// applied main color and rounded corners
    func isMainButton(color: UIColor = SettingsService.shared.mainColor, titleColor: UIColor = SettingsService.shared.grayColor) {
        //        self.layer.borderWidth = 2
        //        self.layer.borderColor = UIColor.white.cgColor
        backgroundColor = color
        titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        setTitleColor(titleColor, for: .normal)
        //        self.layer.cornerRadius = self.frame.height / 5
        layer.cornerRadius = 10
        clipsToBounds = true
        //        self.layer.masksToBounds = true
    }
    
    func isWhiteButton() {
        backgroundColor = .offWhite
        titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        setTitleColor(.offBlack, for: .normal)
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func isBlackButton(titleColor: UIColor = SettingsService.shared.grayColor) {
        backgroundColor = .offBlack
        titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderWidth = 2 // add a border
        layer.borderColor = SettingsService.shared.isDarkMode ? titleColor.cgColor : UIColor.clear.cgColor
    }
    
    func isClearButton(titleColor: UIColor = SettingsService.shared.mainColor) {
        backgroundColor = .clear
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.borderWidth = 2
        layer.borderColor = titleColor.cgColor
    }
}
