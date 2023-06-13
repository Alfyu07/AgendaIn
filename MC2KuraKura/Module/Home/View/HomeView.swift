//
//  SwiftUIView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    @AppStorage("meetId") var meetId: String = ""
    
    var body: some View {
        ScrollView {
            header
                .padding(.horizontal, 32)
                .onAppear {
                    presenter.getProfile()
                }
            
            joinWithCodeSection
                .padding(.horizontal, 32)
            
            meetingListSection
            navigationToDetail
            
            Spacer().frame(height: 100)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            presenter.getMeetingCardById()
        }
        
    }
    
}

extension HomeView {
    
    var navigationToDetail: some View {
        
        return NavigationLink(destination: presenter.detailView(meeting: presenter.meetingModel ?? MeetingModel()), isActive: $presenter.navigateToDetailFromJoinMeeting) {
        }
    }
    
    var header: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Welcome,")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("gray50"))
                Text(presenter.firstName).font(.system(size: 32, weight: .bold))
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
                HStack {
                    
                    // Fix this later
                    // swiftlint: disable identifier_name
                    PasteButton(payloadType: String.self) { strings in
                        guard let first = strings.first else { return }
                        DispatchQueue.main.async {
                            let arrPasteString = first.map { String($0) }
                            for i in 0..<4 {
                                if i >= arrPasteString.count  {
                                    presenter.codeValue[i] = ""
                                    continue
                                }
                                presenter.codeValue[i] = arrPasteString[i]
                            }
                            print("\(arrPasteString)")
                        }
                    }
                    // swiftlint: disable identifier_name
                    .labelStyle(.iconOnly)
                    .buttonBorderShape(.roundedRectangle(radius: 100))
                    .padding(.top, 6)
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
                        presenter.joinMeetingByCode()
                    }
                }
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 22)
        .background(Color(hex: 0xFFD7E4F7))
        .cornerRadius(30)
        .alert(isPresented: $presenter.isError) {
            Alert(title: Text("Error"), message: Text(presenter.errorMessage), dismissButton: .default(Text("OK")))
        }
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
                        .onChange(of: presenter.searchText) { newValue in
                            presenter.filterSearch()
                        }
                        .frame(width: 100)
                    
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color("blue5"))
                )
            }
            
            ForEach(presenter.meetingCards) { meeting in
                
                let meetingModel = MeetingModel(id: meeting.id, picID: meeting.picID, title: meeting.title, description: "", code: "", location: meeting.location, schedule: meeting.schedule, voteTime: meeting.voteTime, participants: meeting.participants, proposedAgendas: [], status: meeting.status)
                
                
                //Fix this : entah kenapa selalu ke review
//                if false {
                if Date.now > meeting.voteTime.endTime {
                    presenter.linkToReview(for: meetingModel) {
                        MeetingCard(meeting: meetingModel)
                            .padding(.top, 12)
                    }.onAppear{
                        print(meeting.title)
                        print(meeting.voteTime.endTime)
                    }
                } else {
                    presenter.linkToDetail(for: meetingModel) {
                        MeetingCard(meeting: meetingModel)
                            .padding(.top, 12)
                    }
                }
            }
        }.padding(.horizontal, 32)
            .padding(.top, 24)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(presenter: HomePresenter(homeUseCase: Injection.init().provideHome()))
    }
}
