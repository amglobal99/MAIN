//
//  ExtensionDate.swift
//  MAIN
//
//  Created by amglobal on 4/6/20.
//  Copyright © 2020 Natsys. All rights reserved.
//

import Foundation


// http://stackoverflow.com/questions/26198526/nsdate-comparison-using-swift
extension Date {
    func isGreaterThan(_ date: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isGreaterThanEqualTo(_ date: Date) -> Bool {
        if self >= date {
            return true
        }
        
        if isGreaterThan(date) {
            return true
        }
        
        return false
    }

    func isLessThan(_ date: Date) -> Bool {
        return date.isGreaterThan(self)
    }

    func isLessThanEqualTo(_ date: Date) -> Bool {
        return date.isGreaterThanEqualTo(self)
    }
    
    // http://stackoverflow.com/questions/27182023/getting-the-difference-between-two-nsdates-in-months-days-hours-minutes-seconds
    func secondsFrom(_ date: Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    
    func timeSinceCurrentDate(_ date: Date) -> String? {
        let timeDifference = abs(date.secondsFrom(self))
        return Formatters.timeOnlyFormatter.string(from: TimeInterval(timeDifference))
    }
    
    func timeSinceCurrentDateLongFormat(_ date: Date) -> String? {
        let timeDifference = abs(date.secondsFrom(self))
        guard var timeString = Formatters.timeOnlyLongFormatter.string(from: TimeInterval(timeDifference)) else {
            return nil
        }
        timeString = timeString.replacingOccurrences(of: ",", with: " and")
        return timeString
    }
    
    
    
    // Return the date as Friday, January 20th
    public var ordinalString: String {
        let components = (Calendar.current as NSCalendar).components([.day], from: self)
        let ordinalDay = Formatters.ordinalFormmatter.string(from: NSNumber(value:components.day!))
        let formattedDate = Formatters.dayMonthFormatter.string(from: self)
        return "\(formattedDate) \(ordinalDay!)"
    }
    
    
    
    
}
