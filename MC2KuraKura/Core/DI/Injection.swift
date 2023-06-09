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
    
    private func provideHomeRepository() -> UserRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return UserRepository.sharedInstance(remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideHomeRepository()
        return HomeInteractor(userRepository: repository)
    }
    
    private func provideDetailRepository() -> DetailRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return DetailRepository.sharedInstance(remote)
    }
    
    func provideDetail(for meeting: MeetingModel) -> DetailUseCase {
        let repository = provideDetailRepository()
        return DetailInteractor(repository: repository, meeting: meeting)
    }
    
    // meeting injection
    private func provideMeetingRepository() -> MeetingRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MeetingRepository.sharedInstance(remote)
    }
    
    private func provideUserRepository() -> UserRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return UserRepository.sharedInstance(remote)
    }
    
    func provideMeeting() -> MeetingUseCase {
        let meetingRepository = provideMeetingRepository()
        let userRepository = provideUserRepository()
        return MeetingInteractor(meetingRepository: meetingRepository, userRepository: userRepository)
    }
    //review injection
    func provideReview(for meeting: MeetingModel) -> ReviewUsecase {
        let repository = provideMeetingRepository()
        return ReviewInteractor(repository: repository, meeting: meeting)
    }
}
