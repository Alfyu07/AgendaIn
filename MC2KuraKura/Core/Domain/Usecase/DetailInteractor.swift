//
//  DetailUseCase.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

protocol DetailUseCase {
    func getMeeting() -> MeetingModel
}

class DetailInteractor: DetailUseCase {
    
    private let repository: DetailRepositoryProtocol
    private let meeting: MeetingModel
    
    init(repository: DetailRepositoryProtocol, meeting: MeetingModel) {
        self.repository = repository
        self.meeting = meeting
    }
    
    func getMeeting() -> MeetingModel {
        return meeting
    }
}
