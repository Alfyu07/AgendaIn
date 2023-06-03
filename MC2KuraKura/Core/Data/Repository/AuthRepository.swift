//
//  AuthRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

protocol AuthRepositoryProtocol {
    func login(result: @escaping (Result<UserModel, URLError>) -> Void)
}

final class AuthRepository: NSObject {
    
    typealias AuthInstance = (RemoteDataSource) -> AuthRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: AuthInstance = { remoteRepo in
        return AuthRepository(remote: remoteRepo)
    }
}

extension AuthRepository: AuthRepositoryProtocol {
    func login(result: @escaping (Result<UserModel, URLError>) -> Void) {
        
    }
}
