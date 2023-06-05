//
//  ContentView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var onboardingPresenter: OnboardingPresenter
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var meetingPresenter: MeetingPresenter
    
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    var body: some View {
        NavigationStack {
            if !accessToken.isEmpty && !refreshToken.isEmpty {
                MainView(homePresenter: homePresenter, meetingPresenter: meetingPresenter)
            } else {
                OnboardingView(presenter: onboardingPresenter)
            }
            
//            CodeTextField(numberOfFields: 4)
//           MainView()
        }.fontDesign(.rounded)
            .onAppear{
                print(accessToken)
                print(refreshToken)
            }
    }
}
