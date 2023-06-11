//
//  HomeInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 02/06/23.
//

import Foundation

protocol HomeUseCase {
    func getProfile(completion: @escaping (Result<UserModel, URLError>) -> Void)
    func getMeetingCardByUserID(completion: @escaping (Result<[CardMeetingModel]?, URLError>) -> Void)
}

class HomeInteractor: HomeUseCase {
    
    private let userRepository: UserRepositoryProtocol
    private let meetingRepository: MeetingRepositoryProtocol
     
    init(userRepository: UserRepositoryProtocol, meetingRepository: MeetingRepositoryProtocol) {
        self.userRepository = userRepository
        self.meetingRepository = meetingRepository
    }
    
    func getProfile(completion: @escaping (Result<UserModel, URLError>) -> Void) {
        userRepository.getProfile { result in
            completion(result)
        }
    }
    
    func getMeetingCardByUserID(completion: @escaping (Result<[CardMeetingModel]?, URLError>) -> Void) {
        meetingRepository.getMeetingByUserID { result in
            completion(result)
        }
    }
}
