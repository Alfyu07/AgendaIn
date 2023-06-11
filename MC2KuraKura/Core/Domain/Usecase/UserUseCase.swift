//
//  MeetingInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import Foundation

protocol UserUseCase{
   
    func getProfile(completion: @escaping (Result<UserModel, URLError>) -> Void)
    
}

class UserInteractor: UserUseCase {
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
   
    func getProfile(completion: @escaping (Result<UserModel, URLError>) -> Void) {
        userRepository.getProfile { result in
            completion(result)
        }
    }
}
