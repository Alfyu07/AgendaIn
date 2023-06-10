//
//  StringExtension.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

extension Date {
    static func formatToTimeString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatToDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateString(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
       
        if let date = ISO8601DateFormatter().date(from: dateString) {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            let formattedDate = dateFormatter.string(from: date)
            print(formattedDate)
            return formattedDate
        }
        return ""
    }
    
    static func formatToISOString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "id_ID")
        return dateFormatter.string(from: date)
      }
    
    static func formatToTimeString(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        
        if let date = ISO8601DateFormatter().date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }
        return ""
    }
}
