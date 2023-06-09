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
    @State var draggedItem: AgendaModel?
    @GestureState var dragOffset: CGSize = .zero
    @AppStorage("meetId") var meetId: String = ""
    @AppStorage("userId") var userId: String = ""
    @State private var draggedAgenda: AgendaModel?
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    participantsInfo
                    meetingDetailSection
                    Divider().padding(.top, 30)
                    
                    Text("Here are the voting results that have been collected. You can rearrange the order by dragging and dropping the meeting items before sharing them with all meeting participants.")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .foregroundColor(Color("gray50"))
                    
                    if userId == presenter.meeting.picID.userID {
                        LazyVStack(spacing: 15) {
                            ForEach(0..<presenter.meeting.proposedAgendas.count, id:\.self) { index in
                                let agenda = presenter.meeting.proposedAgendas[index]
                                MeetingReviewCard(
                                    index: index+1,
                                    meeting: presenter.meeting,
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
                        
                    }
                }
            }
            .onAppear{
                presenter.getMeetingByID(id: presenter.meeting.id.isEmpty ? meetId : presenter.meeting.id)
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
    
    struct DropMeetingViewCardDelegate: DropDelegate {
        
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
extension ReviewView {
    var participantsInfo: some View {
        HStack(spacing: 0) {
            if presenter.meeting.participants.count == 0 {
                Text("There are no participants in this meeting")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("blue90"))
            } else if presenter.meeting.participants.count == 1 {
                ProfileImage(firstName: presenter.meeting.participants[0]
                    .firstName, size: 80)
                .padding(.leading, -30)
                .padding(.trailing, 10)
                Text("Only You in this meeting")
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

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(presenter: ReviewPresenter(
            useCase: Injection.init().provideReview(for: MeetingModel()))
        )
    }
}
