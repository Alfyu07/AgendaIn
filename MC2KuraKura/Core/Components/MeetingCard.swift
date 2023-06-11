//
//  MeetingCard.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 01/06/23.
//

import SwiftUI

struct MeetingCard: View {
    var meeting: MeetingModel
    var body: some View {
        HStack(spacing: 0) {
            Circle()
                .fill(Color.random)
                .frame(width: 80, height: 80)
                .overlay {
                    Image("illustration3")
                        .resizable()
                        .scaledToFit()
                }.padding(.trailing, 8)
            VStack(alignment: .leading, spacing: 0) {
                Text(meeting.title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color("blue90"))
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Image(systemName: "calendar.badge.clock")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .scaledToFit()
                            .padding(.trailing, 4)
                        
                        Text(Date.formatToDateString(from: meeting.schedule.date))
                            .font(.system(size: 12))
                    }.foregroundColor(Color("gray50"))
                    Spacer()
                    HStack(spacing: 0) {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .scaledToFit()
                            .padding(.trailing, 4)
                        
                        Text("\(Date.formatToTimeString(from: meeting.schedule.startTime)) - \(Date.formatToTimeString(from: meeting.schedule.endTime))")
                            .font(.system(size: 12))
                    }.foregroundColor(Color("gray50"))
                }
                .padding(.top, 8)
                
                HStack(spacing: 0) {
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .scaledToFit()
                        .padding(.trailing, 4)
                    
                    Text(meeting.location).font(.system(size: 12))
                }.foregroundColor(Color("gray50"))
                    .padding(.top, 6)
                
                HStack(spacing: 0) {
                    // voting status
                    HStack(spacing: 0) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .scaledToFit()
                            .padding(.trailing, 4)
                        
                        Text("Voting \(meeting.status.rawValue)")
                            .font(.system(size: 12))
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .foregroundColor(Color("blue90"))
                    .background(
                        meeting.status == .open ?
                        Color(hex: 0xFF68DFB8) :  Color(hex: 0xFFFA6B9E)
                    )
                    .cornerRadius(10)
                    .padding(.top, 4)
                    
                    Spacer()
                    
                    // participant
                    
                    if meeting.participants.count > 3 {
                        HStack(spacing: 0) {
                            ForEach(0..<3, id: \.self) { index in
                                ProfileImage(firstName: meeting.participants[index].firstName, size: 24)
                                    .padding(.leading, -8)
                            }
                            
                            Text("+\(meeting.participants.count - 3)")
                                .font(.system(size: 8))
                                .foregroundColor(Color("gray50"))
                        }.offset(CGSize(width: 0, height: -6))
                    } else {
                        HStack(spacing: 0) {
                            ForEach(meeting.participants) { participant in
                                ProfileImage(firstName: participant.firstName, size: 24)
                                    .padding(.leading, -8)
                            }.offset(CGSize(width: 0, height: -6))
                        }
                    }
                }.padding(.top, 4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: Color("shadowColor"), radius: 40.0, x: 0.0, y: 16.0)
        
    }
    
}
