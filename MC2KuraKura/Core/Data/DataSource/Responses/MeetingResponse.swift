//
//  File.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 08/06/23.
//

import Foundation

struct MeetingResponse: Decodable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case PICID = "picid"
        case title =  "title"
        case description = "description"
        case code = "code"
        case location = "location"
        case schedule = "schedule"
        case voteTime = "voteTime"
        case agenda = "agenda"
        case participants = "participants"
    }
    var id: String?
    var PICID: PICID?
    var title: String?
    var description: String?
    var code: String?
    var location: String?
    var schedule: MeetingTimeRequest?
    var voteTime: MeetingTimeRequest?
    var agenda: [AgendaModel]
    var participants: [Participant]
}

struct GetMeetingByUserIDResponse: Decodable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case id = "meetId"
        case PICID = "picid"
        case title =  "title"
        case location = "location"
        case schedule = "schedule"
        case voteTime = "voteTime"
        case participants = "participants"
    }
    
    var id: String?
    var PICID: PICID?
    var title: String?
    var location: String?
    var schedule: MeetingTimeRequest?
    var voteTime: MeetingTimeRequest?
    var participants: [Participant]
}
