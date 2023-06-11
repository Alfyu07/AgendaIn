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
    
    var title: String?
    var description: String?
    var location: String?
    var schedule: MeetingTimeRequest?
    var voteTime: MeetingTimeRequest?
    var agenda: [AddAgendaRequest]
}

struct MeetingTimeRequest: Codable{
    private enum CodingKeys: String, CodingKey {
        case date =  "date"
        case startTime = "startTime"
        case endTime = "endTime"
    }
    
    var date: String
    var startTime: String
    var endTime: String
}

struct AddAgendaRequest: Codable {
    private enum CodingKeys: String, CodingKey{
        case title =  "title"
        case description = "description"
    }
    
    var title: String?
    var description: String?
}

struct GetMeetingRequest: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "meetId"
    }
    
    var id: String?
}


struct JoinMeetingRequest: Codable {
    private enum CodingKeys: String, CodingKey {
        case meetingCode = "meetingCode"
    }
    
    var meetingCode: String?
}

//struct AddAgendaRequest: Codable {
//    
//}
