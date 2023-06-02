//
//  User.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

struct UserModel: Identifiable, Equatable {
    let id: String
    let name: String
    let imgUrl: String
    
    static let sharedExample = UserModel(
        id: UUID().uuidString,
        name: "Wahyu",
        imgUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=988&q=80"
        )
}
