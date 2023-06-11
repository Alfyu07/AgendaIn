//
//  OnboardingRouter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import SwiftUI

class OnboardingRouter {
    func makeHomeView() -> some View {
        let homeUseCase = Injection.init().provideHome()
        let presenter = HomePresenter(homeUseCase: homeUseCase)
        return HomeView(presenter: presenter)
    }
    
    func makeMainView() -> some View {
        let homeUseCase = Injection.init().provideHome()
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        
        let meetingUseCase = Injection.init().provideMeeting()
        let meetingPresenter = MeetingPresenter(meetingUseCase: meetingUseCase)
        
        let userUseCase = Injection.init().provideUser()
        let profilePresenter = ProfilePresenter(userUsecase: userUseCase)
        
        return MainView(homePresenter: homePresenter, meetingPresenter: meetingPresenter, profilePresenter: profilePresenter)
    }
}
