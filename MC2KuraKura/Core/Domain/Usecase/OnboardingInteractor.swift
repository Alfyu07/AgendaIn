//
//  LoginInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

protocol OnboardingUseCase {
    func signUp(
        request: AuthRequest,
        completion: @escaping (Result<AuthCredential, URLError>) -> Void)
}

class OnboardingInteractor: OnboardingUseCase {
    
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func signUp(request: AuthRequest,
        completion: @escaping (Result<AuthCredential, URLError>) -> Void) {
        repository.signUp(request: request) { result in
            completion(result)
        }
    }
}
