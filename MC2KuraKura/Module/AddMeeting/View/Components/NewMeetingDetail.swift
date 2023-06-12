//
//  DetailView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct NewDetailMeeting: View {
    @ObservedObject var presenter: AddMeetingPresenter
    @EnvironmentObject var envMeeting: MeetingModel
    
    let width: Double
    
    var body: some View {
        if presenter.loadingState {
            ProgressView()
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        } else {
            ScrollView {
                //            participantsInfo
                meetingDetailSection
                agendaSubTitle
                votingDateAndTimeSection
                AgendaList(proposedAgendas: presenter.agendas, width: width)
                    .padding(.horizontal, 32)
                    .padding(.top, 16)
                submitButton
                navigationToDetail
                
            }.background(Color("gray5"))
                .navigationTitle(Text("Meeting Detail"))
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        }
        
    }
}

extension NewDetailMeeting {
    
    var navigationToDetail: some View {
        NavigationLink(destination: presenter.detailView(meeting: presenter.meetingResponse ?? MeetingModel()), isActive: $presenter.shouldRedirectToDetailView) {
        }
    }
    
    var submitButton: some View {
        CustomButton(label: "Submit") {
            presenter.addMeeting()
            
            
        }.padding(.horizontal, 32)
            .padding(.bottom, 32)
    }
    
    var meetingDetailSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(presenter.meeting?.title ?? "")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color("blue90"))
            
            Text(presenter.meeting?.description ?? "")
                .font(.system(size: 14))
                .foregroundColor(Color("gray50"))
                .padding(.top, 8)
            
            HStack {
                HStack(spacing: 0) {
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text(Date.formatDateString(from: presenter.meeting?.schedule?.date ?? ""))
                        .font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                Spacer()
                HStack(spacing: 0) {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text("\(Date.formatToTimeString(from: presenter.meeting?.schedule?.startTime ?? "")) - \(Date.formatToTimeString(from: presenter.meeting?.schedule?.endTime ?? ""))")
                        .font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                Spacer()
                HStack(spacing: 0) {
                    
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text(presenter.meeting?.location ?? "").font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
            }
            .padding(.top, 12)
            
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
                
                Text("Voting Date : \(Date.formatDateString(from: presenter.meeting?.schedule?.date ?? ""))")
                    .font(.system(size: 12))
                Spacer()
            }.foregroundColor(Color("gray50"))
            
            HStack(spacing: 0) {
                Image(systemName: "clock.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .scaledToFit()
                    .padding(.trailing, 4)
                Text("Voting time: \(Date.formatDateString(from: presenter.meeting?.schedule?.startTime ?? "")) - \(Date.formatDateString(from: presenter.meeting?.schedule?.endTime ?? ""))")
                    .font(.system(size: 12))
            }.foregroundColor(Color("gray50"))
        }.padding(.horizontal, 32)
    }
    
}

//struct NewDetailMeeting_Previews: PreviewProvider {
//    static var previews: some View {
//        NewDetailMeeting(
//            presenter: AddMeetingPresenter(meetingUseCase: Injection.init().provideMeeting())
//        )
//    }
//}
