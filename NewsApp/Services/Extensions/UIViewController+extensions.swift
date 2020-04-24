//
//  UIViewController+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 1/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import SwiftUI

extension UIViewController {
    /// method that instantiate a xib file given a string name using Generic
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    /// method that instantiate a xib file given a string name
    static func instantiate() -> Self {
      return self.init(nibName: String(describing: self), bundle: nil)
    }
}

///MARK SwiftUI stuffs
