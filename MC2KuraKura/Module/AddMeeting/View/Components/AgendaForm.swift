//
//  AgendaForm.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 04/06/23.
//

import SwiftUI

struct AgendaForm: View {
    @ObservedObject var presenter: AddMeetingPresenter

    @State var agendas: [AgendaModel] = []
    @State var isAddingAgenda = false
    @State var isEditignAgenda = false
    let width: Double
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if agendas.isEmpty {
                if isAddingAgenda {
                    AgendaFormCard(
                        presenter: presenter,
                        agendas: $agendas, isAddingAgenda: $isAddingAgenda)
                } else {
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
                }
            } else {
                ForEach(agendas) { agenda in
                    AgendaItem(agenda: agenda, isOnVote: false, width: width)
                        .padding(.bottom, 12)
                }
                
                if isAddingAgenda {
                    AgendaFormCard( presenter: presenter,
                        agendas: $agendas, isAddingAgenda: $isAddingAgenda)
                        .padding(.top, 12)
                }
            }
            
            Button {
                isAddingAgenda = true
            } label: {
                VStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color("blue50"))
                        .frame(width: 24)
                    Text("Suggest new meeting agenda")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("blue50"))
                }
                
            }.padding(.top, 12)

            CustomButton(label: "Next") {
                presenter.agendas = agendas
                let agendaRequests = agendas.map { agenda in
                    AddAgendaRequest(title: agenda.title, description: agenda.description)
                }
                presenter.meeting?.agenda = agendaRequests
                presenter.stepIndex += 1
            }.padding(.top, 80)
                .padding(.bottom, 32)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 600)
        .padding(.top, 40)
        .padding(.horizontal, 32)
            .background(Color("gray5"))
    }
}
