//
//  AgendaItem.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct AgendaItem: View {
    let agenda: Agenda
    @State var isExpanding: Bool = true
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
                        
                        HStack(spacing: 0) {
                            ProfileImage(firstName: agenda.firstName, size: 24)
                            Text(agenda.firstName)
                                .font(.system(size: 10))
                                .foregroundColor(Color("gray50"))
                                .padding(.leading, 2)
                        }.offset(CGSize(width: -10, height: 20))
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
        AgendaItem(agenda: .sharedExample)
    }
}
