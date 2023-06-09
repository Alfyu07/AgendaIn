//
//  AuthRequest.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation

struct AuthRequest: Codable {
    private enum CodingKeys: String, CodingKey {
        case validateCode =  "validateCode"
        case firstName = "firstName"
        case lastName = "lastName"
    }
    
    let validateCode: String?
    let firstName: String?
    let lastName: String?
}
