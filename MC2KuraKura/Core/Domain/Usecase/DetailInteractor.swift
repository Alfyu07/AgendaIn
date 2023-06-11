//
//  DetailUseCase.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

protocol DetailUseCase {
    func getMeeting() -> MeetingModel
    func getMeeting(request: GetMeetingRequest, completion: @escaping (Result<MeetingModel, URLError>) -> Void)
}

class DetailInteractor: DetailUseCase {
    
    private let meetingRepository: MeetingRepositoryProtocol
    private let meeting: MeetingModel
    
    init(meetingRepository: MeetingRepositoryProtocol, meeting: MeetingModel) {
        self.meetingRepository = meetingRepository
        self.meeting = meeting
    }
    
    func getMeeting() -> MeetingModel {
        return meeting
    }
    
    func getMeeting(request: GetMeetingRequest, completion: @escaping (Result<MeetingModel, URLError>) -> Void) {
        meetingRepository.getMeeting(request: request) { result in
            completion(result)
        }
    }
}

