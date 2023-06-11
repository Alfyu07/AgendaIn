//
//  VoteMeetingPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

class VotePresenter: ObservableObject {
    //    private let router = AddMeetingRouter()
    private let meetingUseCase: MeetingUseCase
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    // view state
    @Published var stepIndex: Int
    let stepNumber: Int
    let steps: [String]
    @Published var loadingState: Bool = false
    @Published var errorMessage: String = ""
    @Published var shouldRedirectToDetailView = false
    
    // meeting form state
    @Published var meeting: MeetingModel?
    @AppStorage("meetId") var meetId: String = ""
    
    // user state
    @Published var firstName: String = ""
    @Published var user: UserModel = UserModel(id: "", firstName: "", lastName: "", email: "'")
    
    init(meetingUseCase: MeetingUseCase) {
        self.meetingUseCase = meetingUseCase
        self.stepIndex = 0
        self.stepNumber = 2
        self.steps = ["Meeting Item", "Vote"]
    }
    
    
    func getProfile() {
        loadingState = true
        meetingUseCase.getProfile { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    print("user ID : \(user.id)")
                    print("access token : \(self.accessToken)")
                    self.firstName = user.firstName
                    self.loadingState = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                }
            }
        }
        
    }
}
