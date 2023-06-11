//
//  AgendaFormCard.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 04/06/23.
//

import SwiftUI

struct AgendaFormCard: View {
    @ObservedObject var presenter: AddMeetingPresenter
    
    @State var agendaName: String = ""
    @State var agendaDescription: String = ""
    @Binding var agendas: [AgendaModel]
    @Binding var isAddingAgenda: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("", text: $agendaName, prompt: Text("Enter your agenda name")
            )
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color("blue90"))
            
            Divider()
                .padding(.top, 8)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $agendaDescription)
                    .padding(.horizontal, -4)
                    .background(.white)
                    .cornerRadius(10)
                    .frame(height: 80)
                    .font(.system(size: 14))
                    .toolbar {
                        if !agendaName.isEmpty && !agendaDescription.isEmpty {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    
                                    agendas.append(
                                        AgendaModel(
                                            id: UUID().uuidString,
                                            proposerID: presenter.user.id,
                                            firstName: presenter.user.firstName,
                                            title: agendaName,
                                            description: agendaDescription
                                        )
                                    )
                                    isAddingAgenda = false
                                    hideKeyboard()
                                }
                                
                            }
                            
                        }
                    }
                
                if agendaDescription.isEmpty {
                    Text("Enter your meeting description here...")
                        .font(.system(size: 14))
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(.horizontal, 0)
                        .padding(.vertical, 8)
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.white)
        .cornerRadius(15)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

//struct AgendaFormCard_Previews: PreviewProvider {
//    static var previews: some View {
//        AgendaFormCard(presenter: AddMeetingPresenter(meetingUseCase: Injection.init().provideMeeting()),
//                       agendas: .constant([]), isAddingAgenda: .constant(false)
//        )
//    }
//}
