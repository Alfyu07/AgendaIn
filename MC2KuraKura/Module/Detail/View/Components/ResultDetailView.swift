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
    
    @State private var draggedAgenda: AgendaModel?
    @AppStorage("userId") var userId: String = ""
    
    
    var body: some View {
        return GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    participantsInfo
                        .padding(.horizontal, 24)
                    meetingDetailSection
                    Divider().padding(.top, 30)
                    
                    Text("Meeting Agenda").padding(.vertical, 16)
                        .padding(.horizontal, 24)
                    
                    if userId == presenter.meeting.picID.userID {
                        LazyVStack(spacing : 15) {
                            ForEach(0..<presenter.meeting.proposedAgendas.count, id:\.self) { index in
                                let agenda = presenter.meeting.proposedAgendas[index]
                                MeetingReviewCard(
                                    index: index+1,
                                    width: geometry.size.width,
                                    agenda: agenda
                                )
                                .padding(.top, 8)
                                .padding(.horizontal, 24)
                                .onDrag {
                                    self.draggedAgenda = agenda
                                    return NSItemProvider(item: nil, typeIdentifier: agenda.id)
                                }
                                .onDrop(of: [.text], delegate: DropMeetingViewCardDelegate(agenda: agenda, agendas: $presenter.meeting.proposedAgendas, draggedAgenda: $draggedAgenda))
                            }
                        }
                        CustomButton(label: "Save Result") {
                            presenter.saveResultAgendasChange()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                presentationMode.wrappedValue.dismiss()
                            }
                            
                        }
                        .padding(.vertical, 24)
                        .padding(.horizontal, 24)
                    } else {
                        ForEach(0..<presenter.meeting.proposedAgendas.count, id:\.self) { index in
                            let agenda = presenter.meeting.proposedAgendas[index]
                            MeetingReviewCard(
                                index: index+1,
                                width: geometry.size.width,
                                agenda: agenda
                            )
                            .padding(.top, 8)
                            .padding(.horizontal, 24)
                        }
                        // Remove this, this just to indicates if the user is PIC or not
                        Text("Remove This In Production: Only PIC can Drag And Drop List")
                            .padding(.vertical, 24)
                            .padding(.horizontal, 24)
                    }
                }
            }
            .ignoresSafeArea()
            .background(Color("blue5"))
            .navigationBarBackButtonHidden(true)
            .navigationTitle(Text("Result"))
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
    }
    
    struct  DropMeetingViewCardDelegate: DropDelegate {
        
        let agenda : AgendaModel
        @Binding var agendas : [AgendaModel]
        @Binding var draggedAgenda : AgendaModel?
        
        func performDrop(info: DropInfo) -> Bool {
            return true
        }
        
        func dropEntered(info: DropInfo) {
            guard let draggedAgenda = self.draggedAgenda else {
                return
            }
            
            if draggedAgenda != agenda {
                let from = agendas.firstIndex(of: draggedAgenda)!
                let to = agendas.firstIndex(of: agenda)!
                withAnimation(.default) {
                    self.agendas.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
                }
            }
        }
    }
}

extension ResultDetailView {
    
    
    
    
    var participantsInfo: some View {
        HStack(spacing: 0) {
            if presenter.meeting.participants.count == 0 {
                Text("There are no participants in this meeting")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("blue90"))
            } else {
                ForEach(0..<presenter.meeting.participants.count, id: \.self) { index in
                    if index <= 1 {
                        ProfileImage(firstName: presenter.meeting.participants[index]
                            .firstName, size: 80)
                        .padding(.leading, -30)
                    }
                    
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
