//
//  VoteInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

protocol VoteUseCase {
    func submitVoteAgendas(request: AddVoteAgendas, completion: @escaping (Result<MeetingModel, URLError>) -> Void)
    func addAndEditAgenda(request: AddAgendaRequest, completion: @escaping (Result<MeetingModel, URLError>) -> Void)
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
    
    func addAndEditAgenda(request: AddAgendaRequest, completion: @escaping (Result<MeetingModel, URLError>) -> Void) {
        repository.addAndEditAgenda(request: request) { result in
            completion(result)
        }
    }
    
    func submitVoteAgendas(request: AddVoteAgendas, completion: @escaping (Result<MeetingModel, URLError>) -> Void) {
        repository.addVoteAgendas(request: request) { result in
            completion(result)
        }
    }
    
}
