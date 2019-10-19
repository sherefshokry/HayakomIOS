//
//  ProjectBaseUtils.swift
//  A3maly
//
//  Created by Nora Sayed on 10/12/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation


class ProjectBaseUtils {
   static func changeDateFormat(dateString : String)->String{
        let date = dateString.toDate()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.init(localeIdentifier: "ar_EG") as Locale?
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date)
    }
    
    static func formatTime(dateString : String)->String{
        let date = dateString.toDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.init(identifier: "ar_EG")
        return dateFormatter.string(from: date)
    }
    
    static func getTimeString(from date : Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.init(identifier: "ar_EG")
        return dateFormatter.string(from: date)
    }
    
    static func getTime(from string : String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale.init(identifier: "ar_EG")
        return dateFormatter.date(from: string) ?? Date()
        
    }
    
    static func getDateString(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale.init(identifier: "ar_EG")
        return dateFormatter.string(from: date as Date)
    }
    
    static func getDate(string : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale.init(identifier: "en_EG")
        return dateFormatter.date(from: string) ?? Date()
    }
    
//    2019/10/06 "2019/10/06 17:30"
    static func getRequestString(string : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "ar_EG")
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm a"
        let date = dateFormatter.date(from: string) ?? Date()
        dateFormatter.locale = Locale.init(identifier: "en_EG")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getDateForEditForm(string : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_EG")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = dateFormatter.date(from: string) ?? Date()
        dateFormatter.locale = Locale.init(identifier: "ar_EG")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getTimeForEditForm(string : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_EG")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let date = dateFormatter.date(from: string) ?? Date()
        dateFormatter.locale = Locale.init(identifier: "ar_EG")
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date as Date)
    }
    
}
