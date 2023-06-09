//
//  MeetingRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation

protocol MeetingRepositoryProtocol {
    func addMeeting(request: AddMeetingRequest,
                    result: @escaping (Result<MeetingModel, URLError>) -> Void)
    func shareMeeting( result: @escaping (Result<MeetingModel, URLError>) -> Void)
}

class MeetingRepository: NSObject {
    typealias MeetingInstance = (RemoteDataSource) -> MeetingRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: MeetingInstance = { remoteRepo in
        return MeetingRepository(remote: remoteRepo)
    }
}

extension MeetingRepository: MeetingRepositoryProtocol {
    
    func addMeeting(request: AddMeetingRequest, result: @escaping (Result<MeetingModel, URLError>) -> Void) {
        self.remote.addMeeting(request: request) { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                
                let meeting = MeetingModel(id: response.id ?? "" , picID: response.PICID ?? PICID(userID: "", firstName: ""), title: response.title ?? "", description: response.description ?? "", code: response.code ?? "", location: response.location ?? "", schedule: response.schedule ?? MeetingTime(date: Date.now, startTime: Date.now, endTime: Date.now), voteTime: response.voteTime ?? MeetingTime(date: Date.now, startTime: Date.now, endTime: Date.now), participants: [], proposedAgendas: response.agenda, status: .open)
                
                result(.success(meeting))
                
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func shareMeeting(result: @escaping (Result<MeetingModel, URLError>) -> Void) {
        self.remote.shareMeeting { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                // map something here
                print(response)
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
