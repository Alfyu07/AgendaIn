//
//  AgendaItem.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct AgendaItem: View {
    let agenda: AgendaModel
    @State var isExpanding: Bool = true
    let isOnVote: Bool
    @State var voteValue = 0
    
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
                    }.frame(minHeight: 40)
                    
                    if isOnVote {
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

struct AgendaItem_Previews: PreviewProvider {
    static var previews: some View {
        AgendaItem(agenda: .sharedExample, isOnVote: false)
    }
}
