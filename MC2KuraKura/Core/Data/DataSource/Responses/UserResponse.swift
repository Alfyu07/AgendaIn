//
//  UserResponse.swift
//  MC2KuraKura
//
//  Created by Enzu Ao on 07/06/23.
//

import Foundation

struct GetUserResponse : Decodable{
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName =  "firstName"
        case lastName = "lastName"
        case email = "email"
    }
    
    let id: String?
    let firstName: String?
    let lastName: String?
    let email: String?
}
