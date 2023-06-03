//
//  StringExtension.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

extension Date {
    static func formatToTime(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        return dateFormatter.string(from: date)
    }
    
    static func formatToDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
}
