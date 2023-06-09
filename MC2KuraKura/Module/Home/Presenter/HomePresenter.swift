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
    
    @Published var meetings: [MeetingModel] = [.sharedExample, .sharedExample2]
    
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        self.searchText = ""
        self.codeValue = Array(repeating: "", count: 4)
        self.firstName = ""
    }
    
    func linkBuilder<Content: View>(
        for meeting: MeetingModel,
        ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: meeting)) { content() }
    }
    
    func getProfile() {
        homeUseCase.getProfile { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.firstName = user.firstName
                    print(user.firstName)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                    print(self.errorMessage)
                }
            }
        }
    }
    
}
