//
//  Injection.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//

import Foundation

final class Injection: NSObject {
    private func provideAuthRepository() -> AuthRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        return AuthRepository.sharedInstance(remote)
    }
    
    func provideOnboarding() -> OnboardingUseCase {
        let repository = provideAuthRepository()
        return OnboardingInteractor(repository: repository)
    }
}
