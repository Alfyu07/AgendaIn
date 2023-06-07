//
//  MeetingForm.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct MeetingForm: View {
    @ObservedObject var presenter: AddMeetingPresenter
    @State var meetingName: String = ""
    @State var meetingDescription: String = ""
    @State var meetingLocation: String = ""
    @State var meetingDate: Date = Date.now
    @State var meetingStarts: Date = Date.now
    @State var meetingEnds: Date = Date.now
    @State var votingDate: Date = Date.now
    @State var votingStarts: Date = Date.now
    @State var votingEnds: Date = Date.now
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            inputName
            inputDescription
            inputLocation
            meetingTimeInputGroup
            votingTimeInputGroup
            formButton
        }
        .background(Color("gray5"))
        .padding(.horizontal, 32)
    }
}

extension MeetingForm {
    var inputName: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Meeting Name")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("gray80"))
            
            TextField("Enter your meeting title here...", text: $meetingName)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.white)
                .cornerRadius(10)
                .font(.system(size: 14))
                .padding(.top, 12)
        }.padding(.top, 32)
    }
    
    var inputDescription: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Meeting Description")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("gray80"))
                
            ZStack(alignment: .topLeading) {
                TextEditor(text: $meetingDescription)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(height: 80)
                    .font(.system(size: 14))
                
                if meetingDescription.isEmpty {
                    Text("Enter your meeting description here...")
                        .font(.system(size: 14))
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                }
            }.padding(.top, 12)
        }.padding(.top, 16)
    }
    
    var inputLocation: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Meeting Location")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("gray80"))
            
            TextField("Enter your meeting location here...", text: $meetingLocation)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.white)
                .cornerRadius(10)
                .font(.system(size: 14))
                .padding(.top, 12)
        }.padding(.top, 16)
    }
    
    var meetingTimeInputGroup: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Meeting Time")
                .font(.system(size: 20, weight: .medium))
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 0) {
                DatePicker(selection: $meetingDate, displayedComponents: .date) {
                    Text("Date")
                        .font(.system(size: 16))
                        .foregroundColor(Color("gray80"))
                }.padding(.horizontal, 20)
                
                Divider()
                    .padding(.top, 8)
                
                DatePicker(selection: $meetingStarts, displayedComponents: .hourAndMinute) {
                    Text("Starts")
                        .font(.system(size: 16))
                        .foregroundColor(Color("gray80"))
                }.padding(.horizontal, 20)
                    .padding(.top, 8)
                
                Divider()
                    .padding(.top, 8)
                
                DatePicker(selection: $meetingEnds, displayedComponents: .hourAndMinute) {
                    Text("Ends")
                        .font(.system(size: 16))
                        .foregroundColor(Color("gray80"))
                }.padding(.horizontal, 20)
                    .padding(.top, 8)
                
                Divider()
                    .padding(.top, 8)
            }
            .padding(.top, 8)
            .background(.white)
            .cornerRadius(15)
            .padding(.top, 12)
        }
    }
    
    var votingTimeInputGroup: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Voting Time")
                .font(.system(size: 20, weight: .medium))
                .padding(.top, 16)
            
            VStack(alignment: .leading, spacing: 0) {
                DatePicker(selection: $votingDate, displayedComponents: .date) {
                    Text("Date")
                        .font(.system(size: 16))
                        .foregroundColor(Color("gray80"))
                }.padding(.horizontal, 20)
                
                Divider()
                    .padding(.top, 8)
                
                DatePicker(selection: $votingStarts, displayedComponents: .hourAndMinute) {
                    Text("Starts")
                        .font(.system(size: 16))
                        .foregroundColor(Color("gray80"))
                }.padding(.horizontal, 20)
                    .padding(.top, 8)
                
                Divider()
                    .padding(.top, 8)
                
                DatePicker(selection: $votingEnds, displayedComponents: .hourAndMinute) {
                    Text("Ends")
                        .font(.system(size: 16))
                        .foregroundColor(Color("gray80"))
                }.padding(.horizontal, 20)
                    .padding(.top, 8)
                
                Divider()
                    .padding(.top, 8)
            }
            .padding(.top, 8)
            .background(.white)
            .cornerRadius(15)
            .padding(.top, 12)
        }
    }
    
    var formButton: some View {
        CustomButton(label: "Next") {
            
            
            
            presenter.stepIndex += 1
        }.padding(.vertical, 32)
    }
}

struct MeetingForm_Previews: PreviewProvider {
    static var previews: some View {
        MeetingForm(presenter: AddMeetingPresenter(meetingUseCase: Injection.init().provideMeeting()))
    }
}
