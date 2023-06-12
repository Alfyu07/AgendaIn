//
//  DetailView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var presenter: DetailPresenter
    //    @EnvironmentObject var envMeeting: MeetingModel
    @AppStorage("meetId") var meetId: String = ""
    @AppStorage("userId") var userId: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if userId == presenter.meeting.picID.userID {
                        meetingCodeSection
                    }
                    
                    participantsInfo
                    meetingDetailSection
                    
                    agendaSubTitle
                    votingDateAndTimeSection
                    AgendaList(proposedAgendas: presenter.meeting.proposedAgendas, width: geometry.size.width)
                        .padding(.horizontal, 32)
                        .padding(.top, 16)
                    
                    if userId == presenter.meeting.picID.userID {
                        ManageParticipantSection(presenter: presenter)
                    }
                    
                    Spacer()
                    
                    if userId != presenter.meeting.picID.userID {
                        //                        if false {
                        if Date.now < presenter.meeting.voteTime.startTime {
                            presenter.linkToVote(for: presenter.meeting, isVote: false) {
                                Text("Suggest meeting item")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color("blue50"))
                                    .cornerRadius(30)
                                    .padding(.horizontal, 32)
                            }
                            //                        } else if true {
                        } else if Date.now > presenter.meeting.voteTime.startTime
                                    && Date.now < presenter.meeting.voteTime.endTime {
                            presenter.linkToVote(for: presenter.meeting, isVote: true) {
                                Text("Vote")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color("blue50"))
                                    .cornerRadius(30)
                                    .padding(.horizontal, 32)
                                
                            }
                        }
                    }else if Date.now > presenter.meeting.voteTime.endTime {
                        presenter.linkToResult(for: presenter.meeting) {
                            Text("Show Result")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color("blue50"))
                                .cornerRadius(30)
                                .padding(.horizontal, 32)
                        }
                        
                    }
                    Spacer().frame(height: 32)
                }
                .frame(minHeight: geometry.size.height)
                
            }
        }
        .background(Color("gray5"))
        .navigationTitle(Text("Meeting Detail"))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    // Fix me : navigate back to home after adding meeting
                    NavigationUtil.popToRootView()
                    //                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("blue50"))
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("Settings")
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(Color("blue50"))
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            presenter.getMeetingByID(id: presenter.meeting.id.isEmpty ? meetId : presenter.meeting.id)
        }
    }
}

extension DetailView {
    var meetingCodeSection: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text(presenter.meeting.code)
                    .font(.system(size: 24, weight: .bold))
                    .tracking(8)
                    .foregroundColor(.white)
                
                Button {
                    print("copy")
                } label: {
                    Image(systemName: "doc.on.doc.fill")
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 8)
            .background(Color("blue50"))
            .cornerRadius(30)
            
            Divider().frame(height: 1)
                .background(Color("gray30"))
                .padding(.top, 30)
        }
        .padding(.top, 100)
    }
    var participantsInfo: some View {
        HStack(spacing: 0) {
            if presenter.meeting.participants.isEmpty {
                Text("No participants")
            } else if presenter.meeting.participants.count == 1 {
                ProfileImage(firstName: presenter.meeting.participants[0].firstName, size: 70)
                    .padding(.trailing, 10)
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(presenter.meeting.participants.count) Participant")
                        .foregroundColor(Color("blue90"))
                    HStack {
                        Text(
                            "Only \(presenter.meeting.participants[0].id == userId ? "You" : presenter.meeting.participants[0].firstName) in this meeting"
                        )
                        .font(.system(size: 16, weight: .semibold))
                    }
                }
            } else {
                ForEach(0...1, id: \.self) { index in
                    ProfileImage(firstName: presenter.meeting.participants[index].firstName, size: 70)
                        .padding(.leading, -30)
                }.padding(.trailing, 10)
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(presenter.meeting.participants.count) Participant")
                        .foregroundColor(Color("blue90"))
                    HStack {
                        Text(presenter.getParticipantsName())
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
            
        }
        .padding(.top, userId == presenter.meeting.picID.userID ? 20 : 100)
        .padding(.horizontal, 32)
    }
    var meetingDetailSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(presenter.meeting.title)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color("blue90"))
            
            Text(presenter.meeting.description)
                .font(.system(size: 14))
                .foregroundColor(Color("gray50"))
                .padding(.top, 8)
            
            HStack(spacing: 0) {
                Image(systemName: "person.badge.key.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .padding(.trailing, 4)
                Text("Managed by \(presenter.meeting.picID.userID == userId ? "You" : presenter.meeting.picID.firstName)")
                    .font(.system(size: 12))
            }
            .foregroundColor(Color("gray50"))
            .padding(.top, 12)
            
            HStack {
                HStack(spacing: 0) {
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text(Date.formatToDateString(from: presenter.meeting.schedule.date))
                        .font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                Spacer()
                HStack(spacing: 0) {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    Text("\(Date.formatToTimeString(from: presenter.meeting.schedule.startTime)) - \(Date.formatToTimeString(from: presenter.meeting.schedule.endTime))")
                        .font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                Spacer()
                HStack(spacing: 0) {
                    
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text(presenter.meeting.location).font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
            }
            .padding(.top, 10)
            
        }
        .padding(.top, 16)
        .padding(.horizontal, 32)
    }
    
    var agendaSubTitle: some View {
        HStack {
            Text("Meeting Agenda")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color("gray80"))
            Spacer()
        }
        .padding(.horizontal, 32)
        .padding(.top, 18)
    }
    
    var votingDateAndTimeSection: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Image(systemName: "calendar.badge.clock")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .scaledToFit()
                    .padding(.trailing, 4)
                
                Text("Voting Date : \(Date.formatToDateString(from: presenter.meeting.voteTime.date))")
                    .font(.system(size: 12))
                Spacer()
            }.foregroundColor(Color("gray50"))
            
            HStack(spacing: 0) {
                Image(systemName: "clock.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .scaledToFit()
                    .padding(.trailing, 4)
                Text("Voting time: \(Date.formatToTimeString(from: presenter.meeting.voteTime.startTime)) - \(Date.formatToTimeString(from: presenter.meeting.voteTime.endTime))")
                    .font(.system(size: 12))
            }.foregroundColor(Color("gray50"))
        }.padding(.horizontal, 32)
            .padding(.top, 10)
    }
    
}

