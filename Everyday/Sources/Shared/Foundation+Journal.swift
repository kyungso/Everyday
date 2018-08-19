//
//  Foundation+Journal.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 18..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }()
    
    static var entryTimeFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "h:mm"
        return df
    }()
    
    static var ampmFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "a"
        return df
    }()
}

extension Date {
    var hmsRemoved: Date? {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)
    }
    
    static func before(_ days: Int) -> Date {
        let timeInterval = Double(days) * 24 * 60 * 60
        return Date(timeIntervalSinceNow: -timeInterval)
    }
}
