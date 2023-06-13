//
//  ReviewPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 07/06/23.
//

import SwiftUI

class ReviewPresenter: ObservableObject {
    private let router = OnboardingRouter()
    private let useCase: ReviewUsecase
    
    @Published var meeting: MeetingModel
    
    init(useCase: ReviewUsecase) {
        self.useCase = useCase
        self.meeting = self.useCase.getMeeting()
    }
    
    func getParticipantsName() -> String {
        if meeting.participants.isEmpty {
            return "There are no participants in this meeting"
            
        }
        if meeting.participants.count == 1 {
            return meeting.participants.first!.firstName
            
        }
        
        var hasil: String = ""
        for participant in meeting.participants {
            if participant == meeting.participants.last {
                hasil = hasil + "and " + participant.firstName
            } else {
                hasil = hasil + participant.firstName + ", "
            }
        }
        return hasil
    }
    
    func getMeetingByID(id: String) {
        let request = GetMeetingRequest(id: id)
        useCase.getMeeting(request: request) { result in
            switch result {
            case .success(let meeting):
                DispatchQueue.main.async {
                    self.meeting = meeting
                    //                    self.shouldRedirectToDetailView = true
                    //                    self.loadingState = false
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print("add meeting error : \(error)")
                    //                    self.errorMessage = error.localizedDescription
                    //                    self.loadingState = false
                }
            }
        }
    }
    
    func saveResultAgendasChange() {
        var agendasId: [String] = []
        
        for agenda in meeting.proposedAgendas {
            agendasId.append(agenda.id)
        }
        
        let request = SaveResultAgendasChangesRequest(meetId: meeting.id, agendasId: agendasId)
        useCase.saveResultAgendasChange(request: request) { result in
            switch result {
            case .success(let meeting):
                DispatchQueue.main.async {
                    self.meeting = meeting
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Detail saveResultAgenda Error: \n \(error.localizedDescription)")
                }
            }
        }
    }
    
}
