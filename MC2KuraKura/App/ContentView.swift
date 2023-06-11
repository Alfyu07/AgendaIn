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
            .onAppear {
                // swiftlint:disable line_length
                self.accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ODAyMTQyYTliYmFjNjY5Yjg2MjlkMiIsImZpcnN0TmFtZSI6IldhaHl1IiwiZW1haWwiOiJ3LmFsZmE0MzNAZ21haWwuY29tIiwiZXhwIjoxNzcyNTE4NzIyfQ.ZWFRgLyk-XE4BoFR23jK8eb8BUFPlwhOHGgMnU0Gwj0"
                self.refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0ODAyMTQyYTliYmFjNjY5Yjg2MjlkMiIsImVtYWlsIjoidy5hbGZhNDMzQGdtYWlsLmNvbSIsImV4cCI6MTc3MjUxODcyMn0.gE65Co36J0-5PD4E69_6l72HFX2Ky7UH5GluREMUwCk"
                // swiftlint:enable line_length
            }
            
    }
}
