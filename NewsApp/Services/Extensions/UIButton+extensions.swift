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
        self.backgroundColor = color
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        self.setTitleColor(titleColor, for: .normal)
//        self.layer.cornerRadius = self.frame.height / 5
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
//        self.layer.masksToBounds = true
    }
    
    func isWhiteButton() {
        self.backgroundColor = kOFFWHITECOLOR
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        self.setTitleColor(kOFFBLACKCOLOR, for: .normal)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func isBlackButton(titleColor: UIColor = SettingsService.shared.grayColor) {
        self.backgroundColor = kOFFBLACKCOLOR
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderWidth = 2 //add a border
        self.layer.borderColor = SettingsService.shared.isDarkMode ? titleColor.cgColor : UIColor.clear.cgColor
    }
    
    func isClearButton(titleColor: UIColor = SettingsService.shared.mainColor) {
        self.backgroundColor = .clear
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = titleColor.cgColor
    }
}
