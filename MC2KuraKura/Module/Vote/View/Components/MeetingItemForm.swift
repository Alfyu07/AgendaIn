//
//  VoteAgendaForm.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

struct MeetingItemForm: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var presenter: VotePresenter
    
    @State var agendas: [AgendaModel] = []
    @State var isAddingAgenda = false
    @State var isEditignAgenda = false
    let width: Double
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if agendas.isEmpty {
                if isAddingAgenda {
                    ItemFormCard(
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
                    ItemFormCard( presenter: presenter,
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

            
            CustomButton(label: "Submit") {
                // balik ke detail view & implementasi add agenda
                presentationMode.wrappedValue.dismiss()
            }.padding(.top, 80)
                .padding(.bottom, 32)
            
        }
        .onAppear {
            print("on appear meeting item form")
            agendas = presenter.meeting?.proposedAgendas ?? []
            print(presenter.meeting?.proposedAgendas ?? [])
        }
        .frame(maxWidth: .infinity, maxHeight: 600)
        .padding(.top, 40)
        .padding(.horizontal, 32)
            .background(Color("gray5"))
    }
}
