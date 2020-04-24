//
//  UIImageView+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/16/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UIImage {
    
/// apply tint to an image to whatever color
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()

        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
