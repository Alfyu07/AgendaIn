//
//  AddMeetingRequest.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 07/06/23.
//

import Foundation

struct AddMeetingRequest: Codable {
    private enum CodingKeys: String, CodingKey {
        case title =  "title"
        case description = "description"
        case location = "location"
        case schedule = "schedule"
        case voteTime = "voteTime"
        case agenda = "agenda"
    }
    
    let title: String?
    let description: String?
    let location: String?
    let schedule: MeetingTime?
    let voteTime: MeetingTime?
    let agenda: [Agenda]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(location, forKey: .location)
        try container.encode(schedule, forKey: .schedule)
        try container.encode(voteTime, forKey: .voteTime)
        try container.encode(agenda, forKey: .agenda)
    }
}
