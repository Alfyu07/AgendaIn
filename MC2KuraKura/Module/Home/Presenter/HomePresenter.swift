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
    
    @Published var codeValue: [String] = Array(repeating: "", count: 4)
    let numberOfFields = 4
    
    @Published var searchText: String = ""
    
    @Published var meetings: [MeetingModel] = [.sharedExample, .sharedExample, .sharedExample]
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func linkBuilder<Content: View>(
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(destination: router.makeDetailView()) { content() }
    }
    
}
