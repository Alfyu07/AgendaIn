//
//  VoteMeetingPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

class VotePresenter: ObservableObject {
    //    private let router = AddMeetingRouter()
    private let voteUseCase: VoteUseCase
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
    
    init(voteUsecase: VoteUseCase) {
        self.voteUseCase = voteUsecase
        self.stepIndex = 0
        self.stepNumber = 2
        self.steps = ["Meeting Item", "Vote"]
    }
}
