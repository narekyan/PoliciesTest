//
//  Utils.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import Foundation

class DateUtils {
    static let dateFormatter = DateFormatter()
    
    static func convertDateToSeconds(date: String) -> Int {
        return Int(convertDate(date: date)?.timeIntervalSince1970 ?? 0)
    }
    
    static func convertDate(date: String) -> Date? {
        if let date = date.components(separatedBy: ".").first {
            dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss"
            return dateFormatter.date(from: date)
        }
        return nil
    }
    
    static func userFriendlyTime(seconds: Int) -> String {
        let hours = seconds/3600
        let mins = (seconds%3600)/60
        var result = "\(hours) hours"
        if mins != 0 {
            result += " \(mins) mins"
        }
        return result
    }
}
