//
//  VoteInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

protocol VoteUseCase {
    func submitVote()
    func addNewAgenda()
}

class VoteInteractor: VoteUseCase {
    
    private let repository: VoteRepositoryProtocol
    private let meeting: MeetingModel
    
    init(repository: VoteRepositoryProtocol, meeting: MeetingModel) {
        self.repository = repository
        self.meeting = meeting
    }
    
    func submitVote() {
        
    }
    
    func addNewAgenda() {
        
    }
}
