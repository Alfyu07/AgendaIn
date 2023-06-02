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
    
    private func provideHomeRepository() -> HomeRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return HomeRepository.sharedInstance(remote)
    }
    
    func provideOnboarding() -> OnboardingUseCase {
        let repository = provideAuthRepository()
        return OnboardingInteractor(repository: repository)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideHomeRepository()
        return HomeInteractor(repository: repository)
    }
    
}
