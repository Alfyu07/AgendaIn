//
//  VoteForm.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

struct VoteForm: View {
    @ObservedObject var presenter: VotePresenter
   
    @State var agendas: [AgendaModel] = []
    @State var isAddingAgenda = false
    @State var isEditignAgenda = false
    
    let width: Double
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if agendas.isEmpty {
                VStack(spacing: 0) {
                    Text("You dont have meeting item")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(Color("gray80"))
                    Text("Add your meeting item, so you can manage\nyour meeting")
                        .frame(height: 40)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("gray40"))
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                    
                }
            } else {
                if presenter.checkAlreadyVote() {
                    ForEach(0..<(presenter.meeting?.proposedAgendas.count ?? 0), id: \.self ) { index in
                        AgendaItem(agenda: agendas[index], isOnVote: false, isOnResult: true,  width: width, voteValue: $presenter.values[index])
                            .padding(.bottom, 12)
                    }
                } else {
                    ForEach(0..<(presenter.meeting?.proposedAgendas.count ?? 0), id: \.self ) { index in
                        AgendaItem(agenda: agendas[index], isOnVote: true, width: width, voteValue: $presenter.values[index])
                            .padding(.bottom, 12)
                    }
                    CustomButton(label: "Submit") {
                        presenter.submitVote()
                        
                    }.padding(.top, 80)
                        .padding(.bottom, 32)
                }
            }
            
           
            
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
        .padding(.horizontal, 32)
        .background(Color("gray5"))
        .onAppear {
            agendas = presenter.meeting?.proposedAgendas ?? []
        }
    }
}
