//
//  AddMeetingView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct AddMeetingView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var user: UserModel = .sharedExample2
    @State var stepIndex = 0
    
    let steps: [String] = ["Meeting\nDetail", "Meeting\nItem", "Confirm"]
    let stepNumber: Int = 3
    
    var body: some View {
        ScrollView {
            stepper
            
            switch stepIndex {
            case 0:
                MeetingForm(stepIndex: $stepIndex)
            case 1:
                AgendaForm(stepIndex: $stepIndex)     
            case 2:
                NewDetailMeeting(meeting: .sharedExample)
            default:
                MeetingForm(stepIndex: $stepIndex)
            }
        }.fontDesign(.rounded)
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
                ForEach(0..<stepNumber) { index in
                    VStack(alignment: .center, spacing: 0) {
                        Circle().fill(index == stepIndex ? Color("blue50") : Color("gray50")).frame(width: 16, height: 16)
                        Text(steps[index])
                            .frame(width: 48, height: 32, alignment: .top)
                            .font(.system(size: 12, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(index == stepIndex ? Color("blue50") : Color("gray50"))
                            .padding(.top, 8)
                    }
                    if index != stepNumber - 1 {
                        Spacer()
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            
        }.padding(.top, 100)
            .padding(.horizontal, 32)
    }
}

struct AddMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        AddMeetingView()
    }
}
