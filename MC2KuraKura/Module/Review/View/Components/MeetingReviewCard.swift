//
//  MeetingReviewCard.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 09/06/23.
//

import SwiftUI

struct MeetingReviewCard: View {
    let agenda: AgendaModel
    var body: some View {
        GeometryReader{ geomerry in
            HStack(alignment: .top, spacing: 0) {
                Circle()
                    .fill(Color("blue50"))
                    .frame(width: 36, height: 36)
                    .overlay {
                        Text("1st").font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }.padding(.trailing, 12)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(agenda.title)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("blue90"))
                    Text(agenda.description)
                        .font(.system(size: 12))
                        .foregroundColor(Color("gray80"))
                        .padding(.top, 4)
                    
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text("Engage")
                                .font(.system(size: 10))
                                .foregroundColor(Color("gray80"))
                            Spacer()
                            Text("45%")
                                .font(.system(size: 10))
                                .foregroundColor(Color("gray80"))
                        }
                        
                        ZStack(alignment: .leading){
                            Rectangle()
                                .frame(height: 32)
                                .cornerRadius(30)
                            Rectangle()
                                .fill(.white)
                                .frame(width: 120, height: 32)
                                .cornerRadius(30)
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        
    }
}

struct MeetingReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        MeetingReviewCard(agenda: .sharedExample)
    }
}
