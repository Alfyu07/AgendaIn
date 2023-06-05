//
//  AddNewMeetingPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import Foundation

class AddMeetingPresenter: ObservableObject {
    private let router = AddMeetingRouter()
    private let meetingUseCase: MeetingUseCase
    
    // stepper state
    @Published var stepIndex: Int
    let stepNumber: Int
    let steps: [String]
    
    // meeting form state
    
    
    
    // user state
    var user: UserModel = .sharedExample
    
    init(meetingUseCase: MeetingUseCase) {
        self.meetingUseCase = meetingUseCase
        self.stepIndex = 0
        self.stepNumber = 3
        self.steps = ["Meeting\nDetail", "Meeting\nItem", "Confirm"]
    }
}
