//
//  DetailRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//
import Foundation

protocol DetailRepositoryProtocol {
//    func suggestAgenda()
}

final class DetailRepository: NSObject {
    typealias DetailInstance = (RemoteDataSource) -> DetailRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: DetailInstance = { remoteRepo in
        return DetailRepository(remote: remoteRepo)
    }
}

extension DetailRepository: DetailRepositoryProtocol {
    
//    func suggestAgenda() {
//        
//    }
    
}
