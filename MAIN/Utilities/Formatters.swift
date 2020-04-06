//
//  Formatters.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation

public struct Formatters {

    /// Rounds to 2 decimal places, includes currency symbol (e.g. $719.91)
    public static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        return formatter
    }()

    /// Rounds to 2 decimal places (e.g. 719.91)
    public static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfEven
        formatter.maximumSignificantDigits = 2
        formatter.generatesDecimalNumbers = true
        return formatter
    }()


    /// Rounds to 2 decimal places (e.g. 719.91)
    public static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    /// Add nd, th, st to a number (e.g. 25th)
    public static let ordinalFormmatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter
    }()

    /// Monday, April 25
    public static let longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEE d MMMM")
        return formatter
    }()

    /// Monday, April 25, 2019
    public static let longDateFormatterWithYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d, yyyy")
        return formatter
    }()
  
    /// Mon, Apr 25, 2019
    /// This version displays the abbreviated name for day of week ( for example, Sat instead of Saturday)
    public static let longDateFormatterWithYearShortDayOfWeek: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E, MMM d, yyyy")
        return formatter
    }()
    
    /// Monday, April
    public static let dayMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM"
        return formatter
    }()
    
    /// 06/18
    public static let monthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yy"
        return formatter
    }()

    public static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        return formatter
    }()

    public static let shortTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = DateFormatter.Style.short
        return formatter
    }()
    
    public static let timeOnlyFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter
    }()
    
    public static let timeOnlyLongFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        return formatter
    }()

    // Return a string with a two digit decimal
    // Input 2 returns .2
    // Input 23 returns .23
    // Input 235 returns 2.35
    // Input 2358 returns 23.58
//    public static func fixedDecimal(text: String?) -> String {
//        guard let text = text else {
//            return ""
//        }
//        var decimalSymbol = "."
//        if let currentLanguage = LanguageManager.currentAppleLanguage(), currentLanguage == "fr_CA" {
//            decimalSymbol = ","
//        }
//        var returnText = text.filter("0123456789".contains)
//        if returnText.count == 0 {
//            // do nothing
//        }
//        else if returnText.count < 2 {
//            returnText = decimalSymbol + returnText
//        }
//        else {
//            returnText.insert(Character(decimalSymbol), at: returnText.index(returnText.endIndex, offsetBy: -2))
//            if returnText[returnText.startIndex] == "0" {
//                returnText.remove(at: returnText.startIndex)
//            }
//        }
//        return returnText
//    }
}

extension NSDecimalNumber {

    // If string is empty return an NSDecimalNumber set to 0.0
//    public convenience init(stringValue value: String?) {
//        let locale = Locale(identifier: LanguageManager.currentAppleLanguage() ?? C.LANG.defaultLanguage)
//        let newValue = NSDecimalNumber(string: value, locale: locale)
//        let decimalNumber = (newValue == NSDecimalNumber.notANumber) ? NSDecimalNumber.zero : newValue
//        self.init(value: decimalNumber.floatValue)
//    }

    public var currencyString: String {
        let currencyString = Formatters.currencyFormatter.string(from: NSNumber(value: floatValue))
        guard let currencyValue = currencyString else {
            fatalError("Could not convert NSDecimalNumber to String in \(#file)")
        }
        return currencyValue
    }

    public var displayableString: String {
        guard let displayableString = Formatters.numberFormatter.string(from: self) else {
            fatalError("Could not convert NSDecimalNumber to String in \(#file)")
        }
        return displayableString
    }

    public func lessThanOrEqualToZero() -> Bool {
        return self.compare(0.0).rawValue <= 0
    }
}

