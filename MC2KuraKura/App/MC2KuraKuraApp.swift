//
//  MC2KuraKuraApp.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//

import SwiftUI

@main
struct MC2KuraKuraApp: App {
    let onboardingPresenter = OnboardingPresenter(onBoardingUseCase: Injection.init().provideOnboarding())
    let homePresenter = HomePresenter(homeUseCase: Injection.init().provideHome())
    
    let meetingPresenter = MeetingPresenter(meetingUseCase: Injection.init().provideMeeting())
    @StateObject var envMeeting: MeetingModel = MeetingModel()
    // insert profilePresenter here
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(onboardingPresenter)
                .environmentObject(homePresenter)
                .environmentObject(meetingPresenter)
                .environmentObject(envMeeting)
                
        }
    }
}

