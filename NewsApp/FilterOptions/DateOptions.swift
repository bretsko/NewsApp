//
//  DateOptions.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/10/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

enum DateOptions: String, CaseIterable {
    
    case now = "Now"
    case hours24 = "24 hours"
    case days3 = "3 days"
    case week = "Week"
    case weeks2 = "2 weeks"
    case month = "Month"
    case months3 = "3 months"
    
    var paramString: String {
        switch self {
        case .now:
            return "" //??
        case .hours24:
            return makeISO8601DateByDay(dayCount: -1)
        case .days3:
            return makeISO8601DateByDay(dayCount: -3)
        case .week:
            return makeISO8601DateByWeek(weekCount: -1)
        case .weeks2:
            return makeISO8601DateByWeek(weekCount: -2)
        case .month:
            return makeISO8601DateByWeek(weekCount: -4)
        case .months3:
            return makeISO8601DateByWeek(weekCount: -12)
        }
    }
    
    /// except now
    static var fromAllCases: [DateOptions] {
        [.hours24, .days3, .week, .weeks2, .month, .months3] 
    }
}


/// get the date from a day or whatever dayCount ago
func makeISO8601DateByDay(dayCount: Int = -1) -> String {
    let dayDate = Calendar.current.date(byAdding: .weekday, value: dayCount, to: Date())!
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: dayDate)
}


/// Get the previous date by week.
/// - Parameter weekCount: how many weeks behind. Must be a negative Int
/// - Returns: ISO8601 Date as String
/// - e.g. current date + weekCount * week
func makeISO8601DateByWeek(weekCount: Int = -1) -> String {
    let lastWeekDate = Calendar.current.date(byAdding: .weekOfYear, value: weekCount, to: Date())!
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: lastWeekDate)
}
