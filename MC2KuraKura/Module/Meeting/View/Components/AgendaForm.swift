//
//  AgendaForm.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 04/06/23.
//

import SwiftUI

struct AgendaForm: View {
    @Binding var stepIndex: Int
    
    @State var agendas: [Agenda] = []
    @State var isAddingAgenda = false
    @State var isEditignAgenda = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if agendas.isEmpty {
                if isAddingAgenda {
                    AgendaFormCard(agendas: $agendas, isAddingAgenda: $isAddingAgenda)
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
                    AgendaItem(agenda: agenda)
                        .padding(.bottom, 12)
                }
                
                if isAddingAgenda {
                    AgendaFormCard(agendas: $agendas, isAddingAgenda: $isAddingAgenda)
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
                stepIndex += 1
            }.padding(.top, 80)
                .padding(.bottom, 32)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 600)
        .padding(.top, 40)
        .padding(.horizontal, 32)
            .background(Color("gray5"))
    }
}

struct AgendaForm_Previews: PreviewProvider {
    static var previews: some View {
        AgendaForm(stepIndex: .constant(1))
    }
}
