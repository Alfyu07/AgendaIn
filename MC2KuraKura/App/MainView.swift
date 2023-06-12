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
        GeometryReader{ geometry in
            ZStack(alignment: .bottom) {
                switch index {
                case 0:
                    HomeView(presenter: homePresenter)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                case 2:
                    ProfileView(presenter: profilePresenter)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                default:
                    HomeView(presenter: homePresenter)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                customTabBar
            }
            
            .accentColor(Color("blue50"))
            .navigationBarBackButtonHidden(true)
        }.ignoresSafeArea()
        
        
        
//        TabView(selection: $index) {
//            HomeView(presenter: homePresenter).tabItem {
//                VStack {
//                    Label("Home", systemImage: "house.fill")
//
//                }
//            }.environmentObject(homePresenter)
//                .tag(0)
//            MeetingView(presenter: meetingPresenter, index: $index)
//                .tabItem {
//                    VStack {
//                        Label("Meeting", systemImage: "calendar.badge.plus")
//                    }
//                }
//                .tag(1)
//            ProfileView(presenter: profilePresenter).tabItem {
//                VStack {
//                    Label("Profile", systemImage: "person.fill")
//
//                }
//            }.tag(2)
//
//        }
        
    }
}

extension MainView {
    var customTabBar: some View {
        Rectangle().fill(.white)
            .frame(height: 80)
            .overlay {
                HStack(alignment: .center) {
                    Spacer()
                    Button {
                        index = 0
                    } label: {
                        VStack(alignment: .center){
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            Text("Meetings")
                                .font(.system(size: 10, weight: .semibold))
                        }.foregroundColor(index == 0 ? Color("blue50"): Color("gray40"))
                    }
                    Spacer()
                    
                    Button {
                       index = 0
                    }label: {
                        NavigationLink(destination: AddMeetingView(presenter: AddMeetingPresenter(meetingUseCase: Injection.init().provideMeeting()))) {
                            VStack(alignment: .center) {
                                Image(systemName: "calendar.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                Text("Add Meeting")
                                    .font(.system(size: 10, weight: .semibold))
                            }.foregroundColor(index == 1 ? Color("blue50"): Color("gray40"))
                        }
                    }
                    
                    Spacer()
                    Button {
                        index = 2
                    } label: {
                        VStack(alignment: .center){
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)
                            Text("Profile")
                                .font(.system(size: 10, weight: .semibold))
                        }.foregroundColor(index == 2 ? Color("blue50"): Color("gray40"))
                    }
                    Spacer()
                }
            }
    }
}
