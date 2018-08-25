//
//  Foundation+Journal.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 18..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func formatter(with format: String) -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = format
        return df
    }
    
    static var entryDateFormatter: DateFormatter = DateFormatter.formatter(with: "yyyy. MM. dd. EEE")
    static var entryTimeFormatter: DateFormatter = DateFormatter.formatter(with: "h:mm")
    static var ampmFormatter: DateFormatter = DateFormatter.formatter(with: "a")
}

extension Date {
    // 시간/분/초를 제거한 날짜 구하기
    var hmsRemoved: Date? {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)
    }
    
    static func before(_ days: Int) -> Date {
        let timeInterval = Double(days) * 24 * 60 * 60
        return Date(timeIntervalSinceNow: -timeInterval)
    }
}

// unique() 함수를 구현
extension Array where Element: Hashable {
    func unique() -> [Element] {
        var result: [Element] = []
        var set: Set<Element> = []
        
        for item in self {
            if set.contains(item) == false {
                set.insert(item)
                result.append(item)
            }
        }
        
        return result
    }
}
