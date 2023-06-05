//
//  MainView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 04/06/23.
//

import SwiftUI

struct MainView: View {
    @State var index: Int
    
    let homePresenter: HomePresenter
    let meetingPresenter: MeetingPresenter
    
    init(homePresenter: HomePresenter, meetingPresenter: MeetingPresenter) {
        self.index = 0
        self.homePresenter = homePresenter
        self.meetingPresenter = meetingPresenter
        
        // Customize the appearance of the TabView
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color("gray40"))
        appearance.backgroundColor = UIColor(.white)
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $index) {
            HomeView(presenter: homePresenter).tabItem {
                VStack {
                    Label("Home", systemImage: "house.fill")
                    
                }
            }.environmentObject(homePresenter)
                .tag(0)
            MeetingView(presenter: meetingPresenter)
                .tabItem {
                    VStack {
                        Label("Meeting", systemImage: "calendar.badge.plus")
                    }
                }
                .tag(1)
            ProfileView().tabItem {
                VStack {
                    Label("Profile", systemImage: "person.fill")
                    
                }
            }
            
        }.accentColor(Color("blue50"))
        
            .navigationBarBackButtonHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            homePresenter: HomePresenter(homeUseCase: Injection.init().provideHome()),
            
            meetingPresenter: MeetingPresenter(meetingUseCase: Injection.init().provideMeeting())
        )
    }
}
