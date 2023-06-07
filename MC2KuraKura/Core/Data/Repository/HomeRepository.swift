//
//  HomeRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 02/06/23.
//

// Delete this
import Foundation

protocol HomeRepositoryProtocol {
    func joinMeeting(code: String)
}

final class HomeRepository: NSObject {
    typealias HomeInstance = (RemoteDataSource) -> HomeRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: HomeInstance = { remoteRepo in
        return HomeRepository(remote: remoteRepo)
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    
    func joinMeeting(code: String) {
        
    }
}
