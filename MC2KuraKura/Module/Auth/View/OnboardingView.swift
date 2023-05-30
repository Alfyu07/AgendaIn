//
//  LoginView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 30/05/23.
//

import SwiftUI

struct OnboardingView: View {
    //    @ObservedObject var presenter = LoginPresenter
    @State var index = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 40)
            Text("Let's Make")
                .font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundColor(Color("blue50")) +
            
            Text(" Your Meeting")
                .font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundColor(Color("yellow50"))
            
            Text("Determine your agenda")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color("darkBlue40")).padding(.top, 2)
            
            VStack(alignment: .center, spacing: 0) {
                Image("illustration1")
                    .resizable()
                    .frame(width: 350, height: 284)
                    .scaledToFit()
                    .padding(.top, -6)
                //                    .padding(.bottom, 120)
                
                // swiftlint:disable line_length
                VStack(alignment: .center) {
                    Text("Collaborative")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("blue90"))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
//                        .padding(.top, 30)
                    Text("We will create the meeting agenda together,\nCollaboration and thoughts will merge \nIdeas will emerge, concepts will be formed,\nSo that this meeting is successful and focused.")
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color("blue90"))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                    
                    HStack {
                        ForEach(1..<4) { number in
                            Circle().fill(
                                index == number ? Color("blue40") :
                                    Color("blue20")
                            )
                            .frame(width: 8.5, height: 8.5)
                            .scaleEffect(index == number ? 1.5 : 1)
                            .animation(
                                .spring()
                            )
                        }
                    }
                    .padding(.top, 10)
                }.padding(.top, 200)
                
                // swiftlint:enable line_length
                
                Button {
                    if index == 3 {
                      // login function here
                    } else {
                        index += 1
                    }
                   
                } label: {
                    if index == 3 {
                        HStack {
                            Image(systemName: "apple.logo")
                                .padding(.trailing, 8)
                            Text("Login With Apple ID")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                    } else {
                            Text("Continue")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .accentColor(index == 3 ? .black : Color("blue50"))
                .cornerRadius(30)
                .padding(.top, 16)
                .padding(.horizontal, 24)
//                .animation(.spring())
            }
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            VStack {
                Spacer()
                Image("onboardingBg").resizable().scaledToFit()
            }.frame(maxWidth: .infinity))
        .ignoresSafeArea(.container)
    }
}
