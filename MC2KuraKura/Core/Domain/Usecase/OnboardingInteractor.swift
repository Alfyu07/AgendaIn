//
//  LoginInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

protocol OnboardingUseCase {
    func login(completion: @escaping (Result<UserModel, URLError>) -> Void)
}

class OnboardingInteractor: OnboardingUseCase {
    private let repository : AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func login(completion: @escaping (Result<UserModel, URLError>) -> Void) {
        
    }
}
