//
//  VoteView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

struct VoteView: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var presenter: VotePresenter
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack{
                    CustomStepper(stepNumber: 2, steps: presenter.steps, stepIndex: $presenter.stepIndex)
                        .padding(.top, 120)
                        .padding(.horizontal, 32)
                    
                    switch presenter.stepIndex {
                    case 0:
                        MeetingItemForm(presenter: presenter, width: geometry.size.width)
                    case 1:
                        VoteForm(presenter: presenter, width: geometry.size.width)
                    default:
                        MeetingItemForm(presenter: presenter, width: geometry.size.width)
                    }
                }
            }
            
        }
        .fontDesign(.rounded)
        .background(Color("gray5"))
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
        }
        .navigationTitle("Add New Meeting")
        .navigationBarBackButtonHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
//        .onAppear {
//            presenter.getProfile()
//        }
    }
}

//struct VoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        VoteView()
//    }
//}
