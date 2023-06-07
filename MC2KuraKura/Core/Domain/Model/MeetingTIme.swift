//
//  MeetingTIme.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 07/06/23.
//

import Foundation

struct MeetingTime: Codable, Equatable {
    var date: Date
    var startTime: Date
    var endTime: Date
    
    static let scheduleExample = MeetingTime(
        date: Date.now, startTime: Date.now - 5000, endTime: Date.now + 5000)
    static let voteTimeExample = MeetingTime(
        date: Date.now, startTime: Date.now + 2000, endTime: Date.now + 4000)
}
