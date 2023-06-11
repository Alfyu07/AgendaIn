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
    func getMeeting(requset: GetMeetingRequest,
                    result: @escaping (Result<MeetingModel, URLError>) -> Void)
    func getMeetingByUserID( result: @escaping (Result<[CardMeetingModel]?, URLError>) -> Void)
    func joinMeetingByCode(request: JoinMeetingRequest, result: @escaping (Result<MeetingModel, URLError>) -> Void)
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
    func getMeeting(requset: GetMeetingRequest, result: @escaping (Result<MeetingModel, URLError>) -> Void) {
        self.remote.getMeetingById(request: requset) { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                let meeting = MeetingMapper.mapAddMeetingResponseToDomain(input: response)
                
                result(.success(meeting))
                
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func addMeeting(request: AddMeetingRequest, result: @escaping (Result<MeetingModel, URLError>) -> Void) {
        self.remote.addMeeting(request: request) { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                let meeting = MeetingMapper.mapAddMeetingResponseToDomain(input: response)
                
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
    
    func getMeetingByUserID(result: @escaping (Result<[CardMeetingModel]?, URLError>) -> Void) {
        self.remote.getMeetingByUserId { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                let cardMeetings = MeetingMapper.mapGetMeetingByUserIDResponseToDomain(input: response)
                result(.success(cardMeetings))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func joinMeetingByCode(request: JoinMeetingRequest, result: @escaping (Result<MeetingModel, URLError>) -> Void) {
        self.remote.joinMeetingByCode(request: request) { remoteResponse in
            switch remoteResponse {
            case .success(let response):
                let meeting = MeetingMapper.mapAddMeetingResponseToDomain(input: response)
                result(.success(meeting))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
