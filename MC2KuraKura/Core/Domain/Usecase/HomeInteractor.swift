//
//  HomeInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 02/06/23.
//

import Foundation

protocol HomeUseCase {
    func getProfile(completion: @escaping (Result<UserModel, URLError>) -> Void)
}

class HomeInteractor: HomeUseCase {
    private let userRepository: UserRepositoryProtocol
     
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func getProfile(completion:  @escaping (Result<UserModel, URLError>) -> Void) {
        userRepository.getProfile { result in
            completion(result)
        }
    }
}
