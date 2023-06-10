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
    
}
