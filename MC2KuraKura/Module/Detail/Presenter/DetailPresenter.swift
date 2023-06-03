//
//  DetailPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    
    @Published var meeting: MeetingModel
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        meeting = self.detailUseCase.getMeeting()
    }
    
    func getParticipantsName() -> String {
        if meeting.participants.isEmpty {
            return "There are no participants in this meeting"
            
        }
        if meeting.participants.count == 1 {
            return meeting.participants.first!.name
            
        }   
        var hasil: String = ""
        for participant in meeting.participants {
            if participant == meeting.participants.last {
                hasil = hasil + "and " + participant.name
            } else {
                hasil = hasil + participant.name + ", "
            }
        }
        return hasil
    }
    
//    func linkBuilder<Content: View>(
//      @ViewBuilder content: () -> Content
//    ) -> some View {
//      NavigationLink(destination: router.makeDetailView()) { content() }
//    }
    
}
