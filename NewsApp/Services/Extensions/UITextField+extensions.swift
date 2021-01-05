//
//  UITextField+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/14/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UITextField {
    
    func isEmailTextField() {
        keyboardType = .emailAddress
        placeholder = "Email"
        clearButtonMode = .whileEditing
    }
    
    func isPasswordTextField() {
        isHidden = false
        isSecureTextEntry = true
        keyboardType = .default
        text = ""
        placeholder = "Password"
        clearButtonMode = .whileEditing
    }
    
    func isPhoneTextField() {
        keyboardType = .phonePad
    }
    
    func isPhoneCodeTextField(isHidden: Bool) {
        keyboardType = .numberPad
        isSecureTextEntry = false
        if isHidden {
            self.isHidden = true
        } else {
            self.isHidden = true
        }
    }
}
