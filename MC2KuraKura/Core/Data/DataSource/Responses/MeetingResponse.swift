//
//  File.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 08/06/23.
//

import Foundation

struct AddMeetingResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case PICID = "PICID"
        case title =  "title"
        case description = "description"
        case code = "code"
        case location = "location"
        case schedule = "schedule"
        case voteTime = "voteTime"
        case agenda = "agenda"
    }
    var id: String?
    var PICID: PICID?
    var title: String?
    var description: String?
    var code: String?
    var location: String?
    var schedule: MeetingTime?
    var voteTime: MeetingTime?
    var agenda: [AgendaModel]
}
