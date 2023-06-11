//
//  MeetingMapper.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 10/06/23.
//

import Foundation
final class MeetingMapper {
    static func mapAddMeetingResponseToDomain(input response: MeetingResponse) -> MeetingModel {
        let schedule = MeetingTime(date: Date.formatISOStringToDate(response.schedule?.date ?? ""), startTime: Date.formatISOStringToDate(response.schedule?.startTime ?? ""), endTime: Date.formatISOStringToDate(response.schedule?.endTime ?? ""))
        
        let voteTime = MeetingTime(date: Date.formatISOStringToDate(response.voteTime?.date ?? ""), startTime: Date.formatISOStringToDate(response.voteTime?.startTime ?? ""), endTime: Date.formatISOStringToDate(response.voteTime?.endTime ?? ""))
        
        return MeetingModel(id: response.id ?? "" , picID: response.PICID ?? PICID(userID: "", firstName: ""), title: response.title ?? "", description: response.description ?? "", code: response.code ?? "", location: response.location ?? "", schedule: schedule, voteTime: voteTime, participants: response.participants , proposedAgendas: response.agenda, status: .open)
    }
    
    static func mapGetMeetingByUserIDResponseToDomain(input responses: [GetMeetingByUserIDResponse]?) -> [CardMeetingModel] {
        
        var cardMeetings: [CardMeetingModel] = []
        
        if let responses = responses {
            for response in responses {
                let schedule = MeetingTime(date: Date.formatISOStringToDate(response.schedule?.date ?? ""), startTime: Date.formatISOStringToDate(response.schedule?.startTime ?? ""), endTime: Date.formatISOStringToDate(response.schedule?.endTime ?? ""))
                
                let voteTime = MeetingTime(date: Date.formatISOStringToDate(response.voteTime?.date ?? ""), startTime: Date.formatISOStringToDate(response.voteTime?.startTime ?? ""), endTime: Date.formatISOStringToDate(response.voteTime?.endTime ?? ""))
                
                cardMeetings.append(CardMeetingModel(id: response.id ?? "" , picID: response.PICID ?? PICID(userID: "", firstName: ""), title: response.title ?? "", location: response.location ?? "", schedule: schedule, voteTime: voteTime, participants: response.participants, status: .open))
            }
        }
        
        return cardMeetings
    }
}
