//
//  AuthCredential.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation

struct AuthCredential:Codable {
    var accessToken: String
    var refreshToken: String
}
