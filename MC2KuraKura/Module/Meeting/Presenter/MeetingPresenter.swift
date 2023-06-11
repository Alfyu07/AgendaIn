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
    
    func getAllMeetings() {
//      loadingState = true
//      homeUseCase.getCategories { result in
//        switch result {
//        case .success(let categories):
//          DispatchQueue.main.async {
//            self.loadingState = false
//            self.categories = categories
//          }
//        case .failure(let error):
//          DispatchQueue.main.async {
//            self.loadingState = false
//            self.errorMessage = error.localizedDescription
//          }
//        }
//      }
        
//        DispatchQueue.main.async {
//            self.meetings = [.sharedExample, .sharedExample2]
//        }
    }
    
    func linkBuilder<Content: View>(
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(destination: router.makeAddMeetingView()) { content() }
    }
}
