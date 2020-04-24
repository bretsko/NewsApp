//
//  Date+extensions.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/21/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension Date {
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }

    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }

    var isYesterday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
}
