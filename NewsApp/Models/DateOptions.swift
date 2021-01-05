//
//  DateOptions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum DateOptions: String, CaseIterable {
    
    case now = "Now", hours24 = "24 hours", days3 = "3 days", week = "Week", weeks2 = "2 weeks", month = "Month", months3 = "3 months"
    
    var asDateParameter: String {
        switch self {
        case .now:
            return ""
        case .hours24:
            return Service.getIso8601DateByDay(dayCount: -1)
        case .days3:
            return Service.getIso8601DateByDay(dayCount: -3)
        case .week:
            return Service.getIso8601DateByWeek(weekCount: -1)
        case .weeks2:
            return Service.getIso8601DateByWeek(weekCount: -2)
        case .month:
            return Service.getIso8601DateByWeek(weekCount: -4)
        case .months3:
            return Service.getIso8601DateByWeek(weekCount: -12)
        }
    }

    /// except now
    static var fromAllCases: [DateOptions] {
        [.hours24, .days3, .week, .weeks2, .month, .months3] 
    }
}
