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
    @AppStorage("userId") var userId: String = ""
    
    // view state
    @Published var stepIndex: Int
    let stepNumber: Int
    let steps: [String]
    @Published var loadingState: Bool = false
    @Published var errorMessage: String = ""
    
    // agenda form state
    @Published var meeting: MeetingModel?
    @Published var agendaRequests: [AgendaRequest]
    @AppStorage("meetId") var meetId: String = ""
    @Published var values: [Int]
    
    
    
//    @Published var voteValues: [Int]
    // user state
    @Published var user: UserModel = UserModel(id: "", firstName: "", lastName: "", email: "'")
    
    init(voteUsecase: VoteUseCase) {
        let meeting = voteUsecase.getMeeting()
        self.voteUseCase = voteUsecase
        self.stepIndex = 0
        self.stepNumber = 2
        self.steps = ["Meeting Item", "Vote"]
        self.meeting = meeting
        self.agendaRequests = []
        self.values = Array(repeating: 0, count: meeting.proposedAgendas.count)
    }
    
    func submitAgenda() {
        loadingState = true
        let request  = AddAgendaRequests(meetingId: meeting?.id ?? meetId, agendas: agendaRequests)
        voteUseCase.addAndEditAgenda(request: request) { result in
            switch result {
            case .success(let meeting):
                print(meeting)
                self.meeting = meeting
                self.loadingState = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error.errorDescription)
                self.loadingState = false
            }
        }
    }
    
    func submitVote() {
        loadingState = true
        let voteRequest = AddVoteAgendas(meetId: meeting?.id, voteValue: values)
        voteUseCase.submitVoteAgendas(request: voteRequest) { result in
            switch result {
            case .success(let meeting):
                print(meeting)
                self.meeting = meeting
                self.loadingState = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error.errorDescription)
                self.loadingState = false
            }
        }
    }
    
    func checkAlreadyVote() -> Bool{
        if let agendas = meeting?.proposedAgendas {
            if agendas.isEmpty {
                return false
            }
            if agendas[0].voters.isEmpty {
                return false
            }
            for voter in agendas[0].voters {
                if voter.userId == userId {
                    return true
                }
            }
        }
        return false
        
    }
}
