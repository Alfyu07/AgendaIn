//
//  DetailView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct NewDetailMeeting: View {
    let meeting: MeetingModel
    var user: UserModel = .sharedExample
    
    var body: some View {
        ScrollView {
            participantsInfo
            meetingDetailSection
            agendaSubTitle
            votingDateAndTimeSection
            AgendaList(proposedAgendas: [.sharedExample, .sharedExample2])
                .padding(.horizontal, 32)
                .padding(.top, 16)
            submitButton
        }.background(Color("gray5"))
        .navigationTitle(Text("Meeting Detail"))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

extension NewDetailMeeting {
    
    var submitButton: some View {
        CustomButton(label: "Submit") {
            print("submit")
        }.padding(.horizontal, 32)
            .padding(.bottom, 32)
    }
    var participantsInfo: some View {
        HStack(spacing: 0) {
            ForEach(0...1, id: \.self) { index in
                ProfileImage(imgUrlString: meeting.participants[index].imgUrl, size: 70)
                    .padding(.leading, -30)
            }.padding(.trailing, 10)
            VStack(alignment: .leading, spacing: 0) {
                Text("\(meeting.participants.count) Participant")
                    .foregroundColor(Color("blue90"))
                HStack {
                    ForEach(meeting.participants) { participant in
                        if participant != meeting.participants.last {
                            Text("\(participant.firstName), ")
                                .font(.system(size: 16, weight: .semibold))
                        } else {
                            Text("and \(participant.firstName)")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                    }
                }
            }
        }
        .padding(.top, 32)
        .padding(.horizontal, 32)
    }
    var meetingDetailSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(meeting.title)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color("blue90"))
            
            Text(meeting.description)
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
                    
                    Text(Date.formatToDate(meeting.date))
                        .font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                Spacer()
                HStack(spacing: 0) {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    Text("\(Date.formatToTime(meeting.startTime)) - \(Date.formatToTime(meeting.endTime))")
                        .font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                Spacer()
                HStack(spacing: 0) {
                    
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text(meeting.location).font(.system(size: 12))
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
                
                Text("Voting Date : \(Date.formatToDate(meeting.date))")
                    .font(.system(size: 12))
                Spacer()
            }.foregroundColor(Color("gray50"))
            
            HStack(spacing: 0) {
                Image(systemName: "clock.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .scaledToFit()
                    .padding(.trailing, 4)
                Text("Voting time: \(Date.formatToTime(meeting.startTime)) - \(Date.formatToTime(meeting.endTime))")
                    .font(.system(size: 12))
            }.foregroundColor(Color("gray50"))
        }.padding(.horizontal, 32)
    }
    
}

struct NewDetailMeeting_Previews: PreviewProvider {
    static var previews: some View {
        NewDetailMeeting(meeting: .sharedExample)
    }
}
