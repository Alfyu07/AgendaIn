//
//  MeetingPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import SwiftUI

class MeetingPresenter: ObservableObject {
    private let router: MeetingRouter = MeetingRouter()
    private let meetingUseCase: MeetingUseCase
    
    // state
    @Published var meetings: [MeetingModel] = []
    
    init(meetingUseCase: MeetingUseCase) {
        self.meetingUseCase = meetingUseCase
    }
    
    func addMeetingView() -> some View {
        
        router.makeAddMeetingView()
    }
    
    func linkBuilder<Content: View>(
      @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeAddMeetingView()) { content() }
    }
}
