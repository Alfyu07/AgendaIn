//
//  AddMeetingView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct AddMeetingView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var envMeeting: MeetingModel
    @StateObject var presenter: AddMeetingPresenter
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                stepper
                switch presenter.stepIndex {
                case 0:
                    MeetingForm(presenter: presenter)
                case 1:
                    AgendaForm(presenter: presenter, width: geometry.size.width)
                case 2:
                    NewDetailMeeting(presenter: presenter, width: geometry.size.width)
                default:
                    MeetingForm(presenter: presenter)
                }
            }
        }
        
        .fontDesign(.rounded)
            .background(Color("gray5"))
            .navigationTitle(Text("Meeting Detail"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
//                        switch presenter.stepIndex {
//                        case 0, 2:
//                            presentationMode.wrappedValue.dismiss()
//                        case 1:
//                            presenter.stepIndex -= 1
//                        default:
//                            presenter.stepIndex -= 1
//                        }
                        if presenter.stepIndex == 0 {
                            presentationMode.wrappedValue.dismiss()
                            presenter.meeting = nil
                        } else {
                            presenter.stepIndex -= 1
                        }
                        
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color("blue50"))
                    }
                }
            }
            .navigationTitle("Add New Meeting")
            .navigationBarBackButtonHidden(false)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onAppear {
                presenter.getProfile()
            }
        
    }
}
// 16 + 32
extension AddMeetingView {
    var stepper: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color("gray40"))
                .frame(height: 3)
                .padding(.top, 6.5)
                .padding(.horizontal)
            
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(0..<presenter.stepNumber) { index in
                    VStack(alignment: .center, spacing: 0) {
                        Circle()
                            .fill(index == presenter.stepIndex ? Color("blue50") : Color("gray50"))
                            .frame(width: 16, height: 16)
                        Text(presenter.steps[index])
                            .frame(width: 48, height: 32, alignment: .top)
                            .font(.system(size: 12, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(index == presenter.stepIndex ? Color("blue50") : Color("gray50"))
                            .padding(.top, 8)
                    }
                    if index != presenter.stepNumber - 1 {
                        Spacer()
                    }
                }
            }
            
        }.padding(.top, 120)
            .padding(.horizontal, 32)
    }
}
