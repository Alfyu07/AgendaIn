//
//  User.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

enum UserRole: Codable {
    case pic
    case participant
}

struct UserModel: Codable, Identifiable, Equatable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    
    static let sharedExample = UserModel(
        id: UUID().uuidString,
        firstName: "Wahyu",
        lastName: "",
        email: "w.alfa433@gmail.com"
        )

    static let sharedExample2 = UserModel(
        id: UUID().uuidString,
        firstName: "Alita",
        lastName: "",
        email: "nindyalita@gmail.com"
    )

}
