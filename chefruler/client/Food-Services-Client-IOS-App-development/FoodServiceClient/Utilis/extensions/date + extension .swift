//
//  Extension + date .swift
//  FoodServiceProvider
//
//  Created by Index on 2/22/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift
extension Date{
    func getStringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        formatter.locale = Locale(identifier: "en")
        return formatter.string(from: self)
    }
    func getLocaizedStringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM"
        if Localize.currentLanguage() == "en"{
            formatter.locale = Locale(identifier: "en")

        } else {
            formatter.locale = Locale(identifier: "ar")

        }
        
        return formatter.string(from: self)
    }
    
    func dateToString(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "YYYY-mm-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    // Returns "Jul 27, 2015, 12:29 PM" PST
    func ABX(dateString:String)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM , yyyy hh:mm:ss "
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        let dateObj = dateFormatter.date(from: dateString)
        //dateFormatter.dateFormat = "d MMM , yyyy hh:mm:ss "
        
        
        return dateObj
        
    }
    func getDateFromString(dateString:String)->Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: dateString) // Returns "Jul 27, 2015, 12:29 PM" PST
        
        return date!
        
        
    }
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {

           if Localize.currentLanguage() == "en" {
            if years(from: date)   > 0 { return "Since \(years(from: date)) years ago"   }
            if months(from: date)  > 0 { return "Since \(months(from: date)) months ago"  }
            if weeks(from: date)   > 0 { return "Since \(weeks(from: date)) weeks ago"   }
            if days(from: date)    > 0 { return "Since \(days(from: date)) days ago"    }
            if hours(from: date)   > 0 { return "Since \(hours(from: date)) hours  ago"   }
            if minutes(from: date) > 0 { return "Since \(minutes(from: date)) minutes ago" }
            if seconds(from: date) > 0 { return "Since \(seconds(from: date)) seconds ago" }
            return ""
            } else {
            if years(from: date)   > 0 { return " منذ \(years(from: date)) سنة"   }
            if months(from: date)  > 0 { return " منذ  \(months(from: date)) شهر"  }
            if weeks(from: date)   > 0 { return "منذ \(weeks(from: date)) اسبوع"   }
            if days(from: date)    > 0 { return "منذ \(days(from: date)) يوم"    }
            if hours(from: date)   > 0 { return "منذ \(hours(from: date)) ساعة"   }
            if minutes(from: date) > 0 { return " منذ \(minutes(from: date)) دقيقة " }
            if seconds(from: date) > 0 { return "منذ \(seconds(from: date)) ثانية" }
            return ""
            }
        
        
}
  
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }

    var millisecondsSince1970:Int
    {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func getTimeFromString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Localize.currentLanguage())
        if Calendar.current.isDateInToday(self) {
            dateFormatter.dateFormat = "hh:mm a"
        } else if Calendar.current.isDateInYesterday(self) {
            dateFormatter.dateStyle = .medium
            dateFormatter.doesRelativeDateFormatting = true
        } else {
            if Localize.currentLanguage() == "ar" {
                dateFormatter.dateFormat = "yyyy/MM/dd"
            } else {
                dateFormatter.dateFormat = "dd/MM/yyyy"
            }
        }
        return dateFormatter.string(from: self)
    }
    
    
}
