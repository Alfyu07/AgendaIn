//
//  VoteRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

protocol VoteRepositoryProtocol {
    func addAndEditAgenda(request: AddAgendaRequests, result: @escaping (Result<MeetingModel, URLError>) -> Void)
    func addVoteAgendas(request: AddVoteAgendas, result: @escaping (Result<MeetingModel, URLError>) -> Void)
}

final class VoteRepository: NSObject {
    typealias VoteInstance = (RemoteDataSource) -> VoteRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: VoteInstance = { remoteRepo in
        return VoteRepository(remote: remoteRepo)
    }
}

extension VoteRepository: VoteRepositoryProtocol {
    func addVoteAgendas(request: AddVoteAgendas, result: @escaping (Result<MeetingModel, URLError>) -> Void) {
        self.remote.addVotesAgenda(request: request) { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                let meeting = MeetingMapper.mapAddMeetingResponseToDomain(input: response)
                result(.success(meeting))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func addAndEditAgenda(request: AddAgendaRequests, result: @escaping (Result<MeetingModel, URLError>) -> Void) {
        self.remote.addMeetingAgenda (request: request) { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                let meeting = MeetingMapper.mapAddMeetingResponseToDomain(input: response)
                result(.success(meeting))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    
//    func suggestAgenda() {
//
//    }
    
}
