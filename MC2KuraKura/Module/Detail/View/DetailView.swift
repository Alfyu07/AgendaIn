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
    
    
    //Mark : mungkin nanti dijadiin environtment object
    var user: UserModel = .sharedExample
    
    var body: some View {
        ScrollView {
            Spacer().frame(height: 50)
            
            if user.role == .pic {
                meetingCodeSection
            }
           
            participantsInfo
            meetingDetailSection
                   
            agendaSubTitle
            votingDateAndTimeSection
            AgendaList(presenter: presenter)
                .padding(.horizontal, 32)
                .padding(.top, 16)
            
            if user.role == .pic {
                ManageParticipantSection(presenter: presenter)
            }
            
            if user.role == .participant {
                Spacer().frame(height: 32)
                
                if Date.now < presenter.meeting.votingStartTime {
                    presenter.linkBuilder {
                        Text("Suggest meeting item")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color("blue50"))
                            .cornerRadius(30)
                            .padding(.horizontal, 32)
                    }
                    
                } else if Date.now > presenter.meeting.votingStartTime
                            && Date.now < presenter.meeting.votingEndTime {
                    presenter.linkBuilder {
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
                    
            }
        }.background(Color("gray5"))
        .navigationTitle(Text("Meeting Detail"))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
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
        .padding(.top, 50)
    }
    var participantsInfo: some View {
        HStack(spacing: 0) {
            ForEach(0...1, id: \.self) { index in
                ProfileImage(imgUrlString: presenter.meeting.participants[index].imgUrl, size: 70)
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
        .padding(.top, 50)
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
            
            HStack {
                HStack(spacing: 0) {
                    Image(systemName: "calendar.badge.clock")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text(Date.formatToDate(presenter.meeting.date))
                        .font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                Spacer()
                HStack(spacing: 0) {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    Text("\(Date.formatToTime(presenter.meeting.startTime)) - \(Date.formatToTime(presenter.meeting.endTime))")
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
                
                Text("Voting Date : \(Date.formatToDate(presenter.meeting.date))")
                    .font(.system(size: 12))
                Spacer()
            }.foregroundColor(Color("gray50"))
            
            HStack(spacing: 0) {
                Image(systemName: "clock.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .scaledToFit()
                    .padding(.trailing, 4)
                Text("Voting time: \(Date.formatToTime(presenter.meeting.startTime)) - \(Date.formatToTime(presenter.meeting.endTime))")
                    .font(.system(size: 12))
            }.foregroundColor(Color("gray50"))
        }.padding(.horizontal, 32)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(presenter: DetailPresenter(detailUseCase: Injection.init().provideDetail(for: .sharedExample2)))
    }
}
