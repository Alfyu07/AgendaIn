//
//  ReviesInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 07/06/23.
//

import Foundation

protocol ReviewUsecase {
    func shareMeeting(completion: @escaping (Result<MeetingModel, URLError>) -> Void)
    func getMeeting() -> MeetingModel
}

class ReviewInteractor: ReviewUsecase {
    
    private let repository: MeetingRepositoryProtocol
    private let meeting: MeetingModel
    
    init(repository: MeetingRepositoryProtocol, meeting: MeetingModel) {
        self.repository = repository
        self.meeting = meeting
    }
    
    
    func shareMeeting(completion: @escaping (Result<MeetingModel, URLError>) -> Void) {
        repository.shareMeeting { result in
            completion(result)
        }
    }
    func getMeeting() -> MeetingModel {
        return meeting
    }
}
