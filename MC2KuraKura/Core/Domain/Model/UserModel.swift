//
//  User.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

enum UserRole {
    case pic
    case participant
}

struct UserModel: Identifiable, Equatable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    // Mark : Hapus kalo nanti udah ada method buat get image
    let role: UserRole
    let imgUrl: String
    
     
    static let sharedExample = UserModel(
        id: UUID().uuidString,
        firstName: "Wahyu",
        lastName: "",
        email: "w.alfa433@gmail.com",
        role: UserRole.participant,
        imgUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=988&q=80"
        )

    static let sharedExample2 = UserModel(
        id: UUID().uuidString,
        firstName: "Alita",
        lastName: "",
        email: "nindyalita@gmail.com",
        role: UserRole.pic,
        imgUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=988&q=80"
        )
}
