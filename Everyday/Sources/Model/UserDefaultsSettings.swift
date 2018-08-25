//
//  UserDefaultsSettings.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 25..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit

private let dateFormatOptionKey: String = "dateFormatOptionKey"
private let fontSizeOptionKey: String = "fontSizeOptionKey"

extension UserDefaults: Settings {
    var dateFormatOption: DateFormatOption {
        get {
            let rawValue = object(forKey: dateFormatOptionKey) as? String
            return rawValue.flatMap(DateFormatOption.init) ?? .default
        }
        set {
            set(newValue.rawValue, forKey: dateFormatOptionKey)
            synchronize()
        }
    }
    
    var fontSizeOption: FontSizeOption {
        get {
            let rawValue = object(forKey: fontSizeOptionKey) as? CGFloat
            return rawValue.flatMap(FontSizeOption.init) ?? FontSizeOption.default
//            if
//                let rawValue = rawValue,
//                let option = FontSizeOption(rawValue: rawValue)
//            {
//                return option
//            } else {
//                return FontSizeOption.default
//            }
        }
        set {
            set(newValue.rawValue, forKey: fontSizeOptionKey)
            synchronize()
        }
    }
}
