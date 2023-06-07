//
//  LoginView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 30/05/23.
//

import SwiftUI
import AuthenticationServices

struct OnboardingView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var presenter: OnboardingPresenter
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 40)
            Text("Let's Make")
                .font(.system(size: 26, weight: .black))
                .foregroundColor(Color("blue50")) +
            
            Text(" Your Meeting")
                .font(.system(size: 26, weight: .black))
                .foregroundColor(Color("yellow50"))
            
            Text("Determine your agenda")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("darkBlue40")).padding(.top, 2)
            
            VStack(alignment: .center, spacing: 0) {
                Image("illustration1")
                    .resizable()
                    .frame(width: 350, height: 284)
                    .scaledToFit()
                    .padding(.top, -6)
                
                VStack(alignment: .center) {
                    Text(presenter.onboardingTexts[presenter.index].titleText)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("blue90"))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    
                    Text(presenter.onboardingTexts[presenter.index].descriptionText)
                        .font(.system(size: 14))
                        .foregroundColor(Color("blue90"))
                        .frame(maxWidth: .infinity, maxHeight: 85)
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                    
                    HStack {
                        ForEach(0..<3) { number in
                            Circle().fill(
                                presenter.index == number ? Color("blue40") :
                                    Color("blue20")
                            )
                            .frame(width: 8.5, height: 8.5)
                            .scaleEffect(presenter.index == number ? 1.5 : 1)
                            
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.top, 200)
                
                SignInWithAppleButton(
                    .continue,
                    onRequest: presenter.handle(request:),
                    onCompletion: presenter.handle(completion:)
                )
                .signInWithAppleButtonStyle(
                    colorScheme == .dark ? .white : .black
                )
                .frame(height: 50)
                .cornerRadius(30)
                .padding()
                
                  
                //                presenter.linkBuilder {
                //                    HStack {
                //                        Image(systemName: "apple.logo")
                //                            .padding(.trailing, 8)
                //                        Text("Login With Apple ID")
                //                            .font(.system(size: 16, weight: .bold))
                //                    }
                //                    .frame(maxWidth: 240, maxHeight: 45)
                //                    .padding(.horizontal, 24)
                //                    .foregroundColor(.white)
                //                    .background(.black)
                //                    .cornerRadius(30)
                //                }.padding(.top, 16)
                
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
        .onAppear {
            presenter.autoScroll()
        }
    }
}
