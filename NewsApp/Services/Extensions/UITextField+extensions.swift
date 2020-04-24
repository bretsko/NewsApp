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
        self.keyboardType = .emailAddress
        self.placeholder = "Email"
        self.clearButtonMode = .whileEditing
    }
    
    func isPasswordTextField() {
        self.isHidden = false
        self.isSecureTextEntry = true
        self.keyboardType = .default
        self.text = ""
        self.placeholder = "Password"
        self.clearButtonMode = .whileEditing
    }
    
    func isPhoneTextField() {
        self.keyboardType = .phonePad
    }
    
    func isPhoneCodeTextField(isHidden: Bool) {
        self.keyboardType = .numberPad
        self.isSecureTextEntry = false
        if isHidden {
            self.isHidden = true
        } else {
            self.isHidden = true
        }
    }
}
