//
//  ManageParticipants.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct ManageParticipantSection: View {
    @ObservedObject var presenter: DetailPresenter
    
    @State var query = ""
    private let options = ["Full Access", "Can View", "Can Edit"]
    @State var selectedOption = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Manage Participant")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color("gray80"))
                .padding(.bottom, 12)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Image(systemName: "person.3.sequence.fill")
                        .resizable()
                        .frame(width: 22, height: 10)
                        .foregroundColor(Color("gray50"))
                        .padding(.trailing, 8)
                    
                    TextField(
                        "",
                        text: $query,
                        prompt: Text("Name or email")
                            .font(.system(size: 12, design: .rounded))
                    )
                    .font(.system(size: 12))
                    
                    Menu {
                        Picker("", selection: $selectedOption) {
                            ForEach(0..<options.count) { index in
                                Text(options[index]).tag(index)
                                    .foregroundColor(Color("gray80"))
                                    .font(.system(size: 10))
                            }
                        }
                        .accentColor(Color("gray80"))
                    }label: {
                        HStack {
                            Text(options[selectedOption])
                                .font(.system(size: 10))
                            
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12)
                        }.foregroundColor(Color("gray50"))
                    }
                }
                .padding(.all, 8)
                .cornerRadius(15)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("gray50"), lineWidth: 1)
                }
                
                Text("Only peaople in this list can access")
                    .font(.system(size: 10))
                    .foregroundColor(Color("gray40"))
                    .padding(.top, 12)
                 
                ForEach(presenter.meeting.participants) { participant in
                    HStack {
                        ProfileImage(
                            imgUrlString: participant.imgUrl,
                            size: 32
                        )
                        Text(participant.name)
                            .font(.system(size: 10))
                            .foregroundColor(Color("gray80"))
                        Spacer()
                        Text(participant.name )
                            .font(.system(size: 10))
                            .foregroundColor(Color("gray80"))
                    }.padding(.top, 8)
                }
                
            }
            .padding(.all, 12)
            .padding(.horizontal, 12)
            .background(.white)
            .cornerRadius(15)
        }
        .padding(.horizontal, 32)
       
    }
}

struct ManageParticipantSection_Previews: PreviewProvider {
    static var previews: some View {
        ManageParticipantSection(
            presenter: DetailPresenter(
                detailUseCase: Injection.init().provideDetail(for: .sharedExample2)
            )
        )
    }
}
