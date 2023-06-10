//
//  AddNewMeetingPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI
import Combine

class AddMeetingPresenter: ObservableObject {
    private let router = AddMeetingRouter()
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
    @Published var meeting: AddMeetingRequest?
    var envMeeting: MeetingModel
    @Published var agendas: [AgendaModel] = []
    
    // user state
    @Published var firstName: String = ""
    @Published var user: UserModel = UserModel(id: "", firstName: "", lastName: "", email: "'", role: .participant, imgUrl: "")
    
    init(meetingUseCase: MeetingUseCase, envMeeting: MeetingModel) {
        self.meetingUseCase = meetingUseCase
        self.stepIndex = 0
        self.stepNumber = 3
        self.steps = ["Meeting\nDetail", "Meeting\nItem", "Confirm"]
        self.envMeeting = envMeeting
    }
    
    func updateMeeting(meeting: AddMeetingRequest) {
        self.meeting = meeting
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
    
    func addMeeting() {
        loadingState = true
        meetingUseCase.addMeeting(request: self.meeting!) { result in
            switch result {
            case .success(let meeting):
                DispatchQueue.main.async {
                    self.envMeeting = meeting
                    print(meeting)
                    self.shouldRedirectToDetailView = true
                    self.loadingState = false
                }
            
            case .failure(let error):
                DispatchQueue.main.async {
                    print("add meeting error : \(error)")
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                }
            }
        }
    }
    
    func detailView(meeting: MeetingModel) -> some View {
        router.makeDetailView(for: meeting)
    }
    
}
