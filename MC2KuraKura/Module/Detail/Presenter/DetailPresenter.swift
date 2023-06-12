//
//  DetailPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    private let router = DetailRouter()
    private let detailUseCase: DetailUseCase
    
    @Published var meeting: MeetingModel
    @AppStorage("meetId") var meetId: String = ""
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        self.meeting = detailUseCase.getMeeting()
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
    
    func linkToVote<Content: View>(
        for meeting: MeetingModel,
        isVote: Bool,
        @ViewBuilder content: () -> Content
    ) -> some View {
        return NavigationLink(destination: router.makeVoteView(for: meeting, isVote: isVote)) { content() }
        
    }
    
    func linkToResult<Content: View>(
        for meeting: MeetingModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeResultView(for: meeting)) { content() }
    }
    
    func getMeetingByID(id: String) {
        let request = GetMeetingRequest(id: id)
        detailUseCase.getMeeting(request: request) { result in
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
        detailUseCase.saveResultAgendasChange(request: request) { result in
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
