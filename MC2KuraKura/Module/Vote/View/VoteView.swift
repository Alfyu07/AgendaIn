//
//  VoteView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

struct VoteView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var presenter = VotePresenter(meetingUseCase: Injection.init().provideMeeting())
    var body: some View {
        
        ScrollView {
            CustomStepper(stepNumber: 2, steps: presenter.steps, stepIndex: $presenter.stepIndex)
                .padding(.top, 120)
                .padding(.horizontal, 32)
            switch presenter.stepIndex {
            case 0:
                MeetingItemForm(presenter: presenter)
            case 1:
                MeetingItemForm(presenter: presenter)
            default:
                MeetingItemForm(presenter: presenter)
            }
            
        }
        .fontDesign(.rounded)
        .background(Color("gray5"))
        .navigationTitle(Text("Meeting Detail"))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
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

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView()
    }
}
