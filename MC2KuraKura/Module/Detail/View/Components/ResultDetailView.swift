//
//  ResultDetailView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 12/06/23.
//

import SwiftUI

struct ResultDetailView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var presenter: DetailPresenter
   
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    participantsInfo
                    meetingDetailSection
                    Divider().padding(.top, 30)
                    
                    
                    Text("Meeting Agenda").padding(.vertical, 16)
                    ForEach(presenter.meeting.proposedAgendas) { agenda in
                        MeetingReviewCard(
                            index: 1,
                            width: geometry.size.width,
                            agenda: agenda
                        )
                        .padding(.top, 8)
                        
                    }.padding(.horizontal, 24)
                }
            }
        }
        .ignoresSafeArea()
        .background(Color("blue5"))
        .navigationBarBackButtonHidden(true)
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
    }
    func newIndex(value: DragGesture.Value) -> Int {
        let offsetY = value.location.y
        let itemHeight = UIScreen.main.bounds.size.height / CGFloat(presenter.meeting.proposedAgendas.count)
        let newIndex = min(max(Int(offsetY / itemHeight), 0), presenter.meeting.proposedAgendas.count - 1)
        return newIndex
    }
    
    func reorderItems(from sourceIndex: Int?, to destinationIndex: Int) {
        guard let sourceIndex = sourceIndex else { return }
        let item = presenter.meeting.proposedAgendas.remove(at: sourceIndex)
        presenter.meeting.proposedAgendas.insert(item, at: destinationIndex)
    }
    
}

extension ResultDetailView {
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
        .padding(.top, 100)
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

//struct ResultDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultDetailView()
//    }
//}
