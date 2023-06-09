//
//  ReviewView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 07/06/23.
//

import SwiftUI

struct ReviewView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @StateObject var presenter: ReviewPresenter
    var body: some View {
        ScrollView {
            participantsInfo
            meetingDetailSection
            Divider().padding(.top, 30)
            
            Text("Here are the voting results that have been collected. You can rearrange the order by dragging and dropping the meeting items before sharing them with all meeting participants.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .foregroundColor(Color("gray50"))
        }
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

extension ReviewView {
    var participantsInfo: some View {
        HStack(spacing: 0) {
            ForEach(0...1, id: \.self) { index in
                ProfileImage(firstName: presenter.meeting.participants[index]
                             .firstName, size: 80)
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
        .padding(.top,  100)
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
            .padding(.top, 12)
            
        }
        .padding(.top, 16)
        .padding(.horizontal, 32)
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(presenter: ReviewPresenter(
            useCase: Injection.init().provideReview(for: .sharedExample))
        )
    }
}
