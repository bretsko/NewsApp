//
//  Service.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/16/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class Service {    
//presentAlert
    static func presentAlert(on: UIViewController, title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        on.present(alertVC, animated: true, completion: nil)
    }
    
    static func alertWithActions(on: UIViewController, actions: [UIAlertAction], title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertVC.addAction(action)
        }
        on.present(alertVC, animated: true, completion: nil)
    }
    
    static func dateFormatter() -> DateFormatter { // DateFormatter = A formatter that converts between dates and their textual representations.
        let dateFormatter = DateFormatter()
        let dateFormat = "yyyyMMddHHmmss"
        dateFormatter.dateFormat = dateFormat //dateFormat = "yyyyMMddHHmmss"
        return dateFormatter
    }

    static func imageFromData(pictureData: String, withBlock: (_ image: UIImage?) -> Void ) { //string to image method for imageURL
        var image: UIImage? //container for our image
        let decodedData = NSData(base64Encoded: pictureData, options: NSData.Base64DecodingOptions(rawValue: 0)) //this will decode our string to an NSData
        image = UIImage(data: decodedData! as Data) //assign our image to our decodedData
        withBlock(image)
    }
    
    /// Get the previous date by week.
    /// - Parameter weekCount: how many weeks behind. Must be a negative Int
    /// - Returns: ISO8601 Date as String
    /// - e.g. current date + weekCount * week
    static func getIso8601DateByWeek(weekCount: Int = -1) -> String {
        let lastWeekDate = Calendar.current.date(byAdding: .weekOfYear, value: weekCount, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let lastWeekDateString = dateFormatter.string(from: lastWeekDate)
        return lastWeekDateString
    }
}

