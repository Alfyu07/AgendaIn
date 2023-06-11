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
    let profilePresenter: ProfilePresenter
    
    init(homePresenter: HomePresenter, meetingPresenter: MeetingPresenter, profilePresenter: ProfilePresenter) {
        self.index = 0
        self.homePresenter = homePresenter
        self.meetingPresenter = meetingPresenter
        self.profilePresenter = profilePresenter
        
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
            ProfileView(presenter: profilePresenter).tabItem {
                VStack {
                    Label("Profile", systemImage: "person.fill")
                    
                }
            }.tag(2)
            
        }
        .accentColor(Color("blue50"))
        .navigationBarBackButtonHidden(true)
    }
}


