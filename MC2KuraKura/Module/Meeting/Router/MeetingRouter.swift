//
//  MeetingRouter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import SwiftUI
class MeetingRouter {
    func makeAddMeetingView() -> some View {
        let meetingUseCase = Injection.init().provideMeeting()
        let addMeetingPresenter = AddMeetingPresenter(meetingUseCase: meetingUseCase)
        return AddMeetingView(presenter: addMeetingPresenter)
    }
}
