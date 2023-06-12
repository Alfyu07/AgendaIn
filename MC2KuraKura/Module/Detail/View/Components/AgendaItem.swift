//
//  AgendaItem.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct AgendaItem: View {
    let agenda: AgendaModel
    let isOnVote: Bool
    let isOnResult: Bool
    let width: Double
    
    @State var isExpanding: Bool = true
    @State var voteValue = 0
    
    init(agenda: AgendaModel, isOnVote: Bool = false, isOnResult: Bool = false, width: Double, voteValue: Int = 0) {
        self.agenda = agenda
        self.isOnVote = isOnVote
        self.isOnResult = isOnResult
        self.width = width
        self.voteValue = voteValue
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(agenda.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("gray80"))
                Spacer()
                Button {
                    withAnimation(.spring()) {
                        isExpanding.toggle()
                    }
                    
                } label: {
                    Image(systemName: isExpanding ? "chevron.up.circle" : "chevron.down.circle")
                }.foregroundColor(Color("gray80"))
            }
            if isExpanding {
                VStack(spacing: 0) {
                    Divider()
                        .padding(.top, 8)
                        
                    HStack {
                        Text(agenda.description)
                            .font(.system(size: 12))
                            .foregroundColor(Color("gray80"))
                            .padding(.top, 8)
                            .frame(width: 250, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        HStack(spacing: 0) {
                            ProfileImage(firstName: agenda.firstName, size: 24)
                            Text(agenda.firstName)
                                .font(.system(size: 10))
                                .foregroundColor(Color("gray50"))
                                .padding(.leading, 2)
                        }.offset(CGSize(width: 0, height: 10))
                    }.frame(maxHeight: agenda.description.count < 100 ? 40 : 80)
                         
                    if isOnResult {
                        Divider()
                            .padding(.top, 8)
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Engage")
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("gray80"))
                                Spacer()
                                Text("\(String(format: "%.0f", 0.20132 * 100))%")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(Color("yellow50"))
                            }
                            ProgressBar(width: width, value: 0.45)
                            HStack {
                                HStack(spacing: 0) {
                                    switch agenda.voters.count {
                                    case 0:
                                        Text("No one voted this agenda")
                                            .font(.system(size: 10, weight: .light))
                                            .foregroundColor(Color("gray80"))
                                    case 1...4:
                                        ForEach(0..<4) { index in
                                            ProfileImage(firstName: agenda.voters[index].firstName ?? "", size: 24)
                                        }
                                        Text("+\(agenda.voters.count - 4)").font(.system(size: 8, weight: .light))
                                    default:
                                        ForEach(agenda.voters, id: \.userId) { user in
                                            ProfileImage(firstName: user.firstName ?? "", size: 24)
                                        }
                                    }
                                }
                                Spacer()
                                HStack(spacing: 0) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color("yellow50"))
                                        .frame(width: 24, height: 24)
                                    Text("\(agenda.voters.count)/10")
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundColor(Color("gray80"))
                                }
                            }
                        }
                        .padding(.top, 8)
                    } else if isOnVote {
                        Divider()
                            .padding(.top, 8)
                        HStack(alignment: .center) {
                            ForEach(0..<4, id: \.self) { index in
                                Button {
                                    print("VoteView agendaItem Value : \(voteValue)")
                                    voteValue = index+1
                                } label: {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(voteValue >= index+1 ? Color("yellow50") : Color("gray40"))
                                }
                            }
                        }.padding(.top, 8)
                    }
                    
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(15)
          
    }
}
