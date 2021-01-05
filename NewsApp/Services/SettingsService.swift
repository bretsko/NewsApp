//
//  SettingsService.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/16/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class SettingsService {
    static let shared = SettingsService()
    
    var isDarkMode = false
    var mainColor: UIColor = .purple
    
    //MARK: -
    
    var blackColor: UIColor {
        isDarkMode ? .offWhite : .offBlack
    }

    var whiteColor: UIColor {
        isDarkMode ? .offBlack : .offWhite
    }

    /// whites that will turn gray on dark mode
    var grayColor: UIColor {
        isDarkMode ? .lightGray : .offWhite
    }

    /// black that will turn gray on darkmode
    var darkGrayColor: UIColor {
        isDarkMode ? .lightGray : .offBlack
    }
    
    private init() {
        // don't forget to make this private
    }
    
    func saveIsDarkMode() {
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        UserDefaults.standard.synchronize()
    }
}
