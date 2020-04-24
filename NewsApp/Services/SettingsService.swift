//
//  SettingsService.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/16/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class SettingsService {
    static let shared = SettingsService() //Singleton
    var isDarkMode: Bool = false
    var mainColor: UIColor = kMAINCOLOR
    var blackColor: UIColor { //get only property
        return isDarkMode ? kOFFWHITECOLOR : kOFFBLACKCOLOR
    }
    var whiteColor: UIColor  {
        return isDarkMode ? kOFFBLACKCOLOR : kOFFWHITECOLOR
    }
///whites that will turn gray on dark mode
    var grayColor: UIColor {
        return isDarkMode ? .lightGray : kOFFWHITECOLOR
    }
/// black that will turn gray on darkmode
    var darkGrayColor: UIColor {
        return isDarkMode ? .lightGray : kOFFBLACKCOLOR
    }
    
    private init() {
        // don't forget to make this private
    }
    
    func saveIsDarkMode() {
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        UserDefaults.standard.synchronize()
    }
}
