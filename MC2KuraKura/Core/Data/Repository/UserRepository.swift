//
//  UserRepository.swift
//  MC2KuraKura
//
//  Created by Enzu Ao on 07/06/23.
//

import Foundation

protocol UserRepositoryProtocol {
    func getProfile(result: @escaping (Result<UserModel, URLError>) -> Void)
}

final class UserRepository: NSObject{
    
    typealias UserInstance = (RemoteDataSource) -> UserRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: UserInstance = { remoteRepo in
        return UserRepository(remote: remoteRepo)
    }
}

extension UserRepository: UserRepositoryProtocol {
    func getProfile(result: @escaping (Result<UserModel, URLError>) -> Void) {
        self.remote.getProfile { remoteResponses in
          switch remoteResponses {
          case .success(let getUserResponse):
              let user = UserMapper.mapGetUserResponseToDomain(input: getUserResponse)
            result(.success(user))
          case .failure(let error):
            result(.failure(error))
          }
        }
    }
}
