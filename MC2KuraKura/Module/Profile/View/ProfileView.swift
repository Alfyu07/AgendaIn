//
//  ProfileView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 04/06/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var presenter: ProfilePresenter
    
    var body: some View {
        if presenter.loadingState {
            ProgressView()
                .onAppear {
                    presenter.getProfile()
                }
        } else {
            VStack {
                ProfileImage(firstName: presenter.firstName, size: 132)
                VStack {
                    Text(presenter.firstName)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color("blue90"))
                }
                
                VStack {
                    HStack {
                        Circle()
                            .fill(Color.random)
                            .frame(width: 34, height: 34)
                            .overlay {
                                Image("illustration3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34)
                            }
                            .padding(.trailing, 6)
                        Text("Lorem Ipsum").font(.system(size: 16, weight: .medium))
                        Spacer()
                        Image(systemName: "arrow.forward.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundColor(Color("gray40"))
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 13)
                    .background(.white)
                    .cornerRadius(20)
                    
                    HStack {
                        Circle()
                            .fill(Color.random)
                            .frame(width: 34, height: 34)
                            .overlay {
                                Image("illustration3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34)
                            }
                            .padding(.trailing, 6)
                        Text("Lorem Ipsum").font(.system(size: 16, weight: .medium))
                        Spacer()
                        Image(systemName: "arrow.forward.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundColor(Color("gray40"))
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 13)
                    .background(.white)
                    .cornerRadius(20)
                    .padding(.top, 12)
                }
                    .padding(.top, 36)
                    .padding(.horizontal, 24)
                
                Spacer()
                CustomButton(label: "Logout") {
                    presenter.logout()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
            .padding(.top, 50)
            .fontDesign(.rounded)
                .background(Color("gray5"))
                
        }
        
    }
}
