//
//  MeetingInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation

protocol MeetingUseCase {
    func addMeeting()
    func getAllMeetings()
    
}

class MeetingInteractor: MeetingUseCase {
    private let repository: MeetingRepositoryProtocol
    
    init(repository: MeetingRepositoryProtocol) {
        self.repository = repository
    }
    
    func addMeeting() {
        
    }
    
    func getAllMeetings() {
        
    }
}
