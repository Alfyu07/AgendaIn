//
//  HomePresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 02/06/23.
//

import SwiftUI

class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var codeValue: [String]
    @Published var firstName: String = ""
    
    let numberOfFields = 4
    
    @Published var searchText: String
    
//    @Published var meetings: [MeetingModel] = [.sharedExample, .sharedExample2]
    
    @Published var meetingCards: [CardMeetingModel] = []
    @AppStorage("meetId") var meetId: String = ""
    @AppStorage("userId") var userId: String = ""
    
    @Published var meetingModel: MeetingModel = MeetingModel()
    @Published var tempMeetingCards: [CardMeetingModel] = []
    @Published var errorMessage: String = ""
    @Published var isError: Bool = false
    @Published var loadingState: Bool = false
    
    // state to navigate
    @Published var navigateToDetailFromJoinMeeting: Bool = false
    
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        self.searchText = ""
        self.codeValue = Array(repeating: "", count: 4)
        self.firstName = ""
    }
    
    
    func detailView(meeting: MeetingModel) -> some View {
        router.makeDetailView(for: meeting)
    }
    
    func navigateFromJoinToDetail() -> some View {
        return  router.makeDetailView(for: meetingModel)
    }
    
    func linkToReview<Content: View>(
        for meeting: MeetingModel,
        ViewBuilder content: () -> Content
    ) -> some View {
        return NavigationLink(destination: router.makeReviewView(for: meeting)) { content() }
    }
    
    func linkToDetail<Content: View>(
        for meeting: MeetingModel,
        ViewBuilder content: () -> Content
    ) -> some View {
        return NavigationLink(destination: router.makeDetailView(for: meeting)) { content() }
    }
    
    func getProfile() {
        homeUseCase.getProfile { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.firstName = user.firstName
                    self.userId = user.id
//                    print("Home_User: \n\(user.firstName)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                    print("Home_User_Error: \n\(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func getMeetingCardById() {
        homeUseCase.getMeetingCardByUserID { result in
            switch result {
            case .success(let cardMeetings):
                DispatchQueue.main.async {
                    let sortedCardsByDate = cardMeetings?.sorted{$0.schedule.startTime > $1.schedule.startTime} ?? []
                    self.meetingCards = sortedCardsByDate
                    
                    self.tempMeetingCards = sortedCardsByDate
//                    print("Home_Meeting Cards: \n\(String(describing: cardMeetings))")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                    print("Home_Meeting Cards_Error: \n\(error.localizedDescription)")
                }
            }
        }
    }
    
    func joinMeetingByCode() {
        print("Home_Join Meeting_Execute")
        let joinedCodeValue = codeValue.joined(separator: "")
        let requestJoinMeeting = JoinMeetingRequest(meetingCode: joinedCodeValue)
        homeUseCase.joinMeetingByCode(request: requestJoinMeeting) { result in
            switch result {
            case .success(let meeting):
                DispatchQueue.main.async {
                    self.meetId = meeting.id
                    self.meetingModel = meeting
                    print("Home_Join Meeting: \n\(meeting.id)")
                    self.navigateToDetailFromJoinMeeting = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.loadingState = false
                    print("Home_Join Meeting_Error: \n\(error.localizedDescription)")
                }
            }
        }
    }
    
    func filterSearch() {
        self.meetingCards = tempMeetingCards
        if searchText != "" {
            self.meetingCards = meetingCards
                .filter{$0.title.lowercased()
                    .contains(searchText.lowercased())}
        }
    }
}
