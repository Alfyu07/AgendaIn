//
//  MeetingRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation

protocol MeetingRepositoryProtocol {
    func addMeeting()
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
    
    func addMeeting() {
        
    }
}
