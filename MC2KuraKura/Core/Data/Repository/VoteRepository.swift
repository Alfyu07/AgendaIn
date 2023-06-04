//
//  VoteRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

protocol VoteRepositoryProtocol {
//    func suggestAgenda()
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
    
//    func suggestAgenda() {
//
//    }
    
}
