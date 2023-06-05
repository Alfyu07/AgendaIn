//
//  AuthRepository.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

protocol AuthRepositoryProtocol {
    func signUp(request: AuthRequest,
        result: @escaping (Result<AuthCredential, URLError>) -> Void)
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
    func signUp(request: AuthRequest,
        result: @escaping (Result<AuthCredential, URLError>) -> Void) {
        self.remote.signUp(request: request) { remoteResponses in
          switch remoteResponses {
          case .success(let tokenResponse):
            let token = TokenMapper.mapTokenResponseToDomains(input: tokenResponse)
            result(.success(token))
          case .failure(let error):
            result(.failure(error))
          }
        }
        
        
        
    }
}
