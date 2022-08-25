//
//  NSString+dateFormat.swift
//  Earth1round-iOS
//
//  Created by 황유란 on 2022/08/24.
//

import Foundation

extension String {
    func dateFormat() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.current.identifier)
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS+HH:mm"
        let date = formatter.date(from: self)

        return date
    }
    
    func dateYear() -> String {
        let formattedDate = self.dateFormat() ?? Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy"
    
        let year = formatter.string(from: formattedDate)

        return year
    }
    
    func dateMonthDate() -> String {
        let formattedDate = self.dateFormat() ?? Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "MMMM. dd"
    
        let date = formatter.string(from: formattedDate)

        return date
    }
}
