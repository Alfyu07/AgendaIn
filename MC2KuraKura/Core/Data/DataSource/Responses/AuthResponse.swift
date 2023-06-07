//
//  AuthResponse.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation
struct AuthResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken =  "accessToken"
        case refreshToken = "refreshToken"
    }
    
    let accessToken: String?
    let refreshToken: String?
}
