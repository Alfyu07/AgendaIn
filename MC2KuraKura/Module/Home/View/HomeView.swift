//
//  SwiftUIView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var presenter: HomePresenter
    
//    @State var query: String = ""
    
    var body: some View {
        ScrollView {
            header
                .padding(.horizontal, 32)
            
            joinWithCodeSection
                .padding(.horizontal, 32)
            
            meetingListSection
            
            Spacer().frame(height: 100)
        }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
    }
    
}

extension HomeView {
    var header: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Welcome,")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("gray50"))
                Text("Christina👋").font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color("blue50"))
            }
            Spacer()
            Circle()
                .fill(Color("blue10"))
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: "bell.fill")
                        .foregroundColor(Color("blue50"))
                        .frame(width: 28, height: 28)
                }
        }
        .padding(.top, 50)
    }
    
    var joinWithCodeSection: some View {
        ZStack(alignment: .bottomTrailing) {
            Image("illustration2")
                .offset(CGSize(width: 20, height: 0))
            VStack(alignment: .center, spacing: 0) {
                Text("Join Meeting")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("gray80"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Each participant can contribute\nAnd synergize to achieve the best outcomes.")
                    .font(.system(size: 14))
                    .foregroundColor(Color("gray50"))
                    .padding(.top, 4)
                    .frame(maxWidth: 300, alignment: .leading)
                
                HStack(spacing: 0) {
                    CodeTextField(numberOfFields: 4, codeValue: $presenter.codeValue)
                }.frame(width: 240)
                    .padding(.horizontal, 22)
                    .padding()
                    .background(.white)
                    .frame(width: 200, height: 44)
                    .cornerRadius(30)
                    .padding(.top, 42)
                
                ZStack {
                    Text("Join")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 6)
                }
                .background(Color("blue50"))
                .cornerRadius(30)
                .padding(.top, 6)
                .onTapGesture {
                    print("join")
                }
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 22)
        .background(Color(hex: 0xFFD7E4F7))
        .cornerRadius(30)
    }
    
    var meetingListSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("Your Meeting")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color("blue90"))
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("gray50"))
                    
                    TextField("Search", text: $presenter.searchText)
                        .frame(width: 100)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                            .fill(Color("blue5"))
                )
            }
            
            ForEach(presenter.meetings) { meeting in
                presenter.linkBuilder {
                    MeetingCard(meeting: meeting)
                        .padding(.top, 12)
                }
            }
        }.padding(.horizontal, 32)
            .padding(.top, 24)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(presenter: HomePresenter(homeUseCase: Injection.init().provideHome()))
    }
}
