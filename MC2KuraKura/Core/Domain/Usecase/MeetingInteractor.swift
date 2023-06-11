//
//  MeetingInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation

protocol MeetingUseCase {
    func addMeeting(request: AddMeetingRequest, completion: @escaping (Result<MeetingModel, URLError>) -> Void)
    func getAllMeetings()
    func getProfile(completion: @escaping (Result<UserModel, URLError>) -> Void)
    
}

class MeetingInteractor: MeetingUseCase {
    private let meetingRepository: MeetingRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    
    init(meetingRepository: MeetingRepositoryProtocol, userRepository: UserRepositoryProtocol) {
        self.meetingRepository = meetingRepository
        self.userRepository = userRepository
    }
    
    
    func addMeeting(request: AddMeetingRequest, completion: @escaping (Result<MeetingModel, URLError>) -> Void) {
        meetingRepository.addMeeting(request: request) { result in
            completion(result)
        }
    }
   
    
    func getAllMeetings() {
        
    }
    func getProfile(completion: @escaping (Result<UserModel, URLError>) -> Void) {
        userRepository.getProfile { result in
            completion(result)
        }
    }
}
