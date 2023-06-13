//
//  MeetingReviewCard.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 09/06/23.
//

import SwiftUI

struct MeetingReviewCard: View {
    let index: Int
    let meeting: MeetingModel
    let agenda: AgendaModel
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Circle()
                .fill(Color("blue50"))
                .frame(width: 48, height: 48)
                .overlay {
                    Text(ordinalSuffix(for: index)).font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                }.padding(.trailing, 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(agenda.title)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color("blue90"))
                Text(agenda.description)
                    .font(.system(size: 12))
                    .foregroundColor(Color("gray80"))
                    .padding(.top, 4)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Engagement")
                            .font(.system(size: 10))
                            .foregroundColor(Color("gray80"))
                        Spacer()
                        Text("\(String(format: "%.0f", agenda.result * 100))%")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color("yellow50"))
                    }
                    ProgressBar(value: agenda.result).padding(.top, 4)
                    HStack {
                        HStack(spacing: 0) {
                            if agenda.voters.count == 0 {
                                Text("No one voted this agenda")
                                    .font(.system(size: 10, weight: .light))
                                    .foregroundColor(Color("gray80"))
                            } else if agenda.voters.count > 4 {
                                ForEach(0..<agenda.voters.count) { index in
                                    ProfileImage(firstName: agenda.voters[index].firstName ?? "", size: 24)
                                       
                                }
                                Text("+\(agenda.voters.count - 4)").font(.system(size: 8, weight: .light))
                            } else {
                                ForEach(0..<agenda.voters.count) { index in
                                    ProfileImage(firstName: agenda.voters[index].firstName ?? "", size: 24)
                                }
                            }
                            
                        }
                        .padding(.top, 8)
                        Spacer()
                        HStack(spacing: 0) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("yellow50"))
                                .frame(width: 24, height: 24)
                            Text("\(agenda.voters.count)/\(meeting.participants.count)")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(Color("gray80"))
                        }
                        .padding(.top, 8)
                    }.padding(.top, 8)
                }
                .padding(.top, 8)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 10)
        .background(.white)
        .cornerRadius(10)
    }
    
    func ordinalSuffix(for index: Int) -> String {
        let suffixes = ["st", "nd", "rd"]
        let remainderTen = index % 10
        let remainderHundred = index % 100
        
        if remainderTen == 1 && remainderHundred != 11 {
            return "\(index)st"
        } else if remainderTen == 2 && remainderHundred != 12 {
            return "\(index)nd"
        } else if remainderTen == 3 && remainderHundred != 13 {
            return "\(index)rd"
        } else {
            return "\(index)th"
        }
    }
}


