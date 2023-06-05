//
//  TokenMapper.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 05/06/23.
//

import Foundation

final class TokenMapper {
    static func mapTokenResponseToDomains(input authResponse: AuthResponse) ->  AuthCredential {
        
        return AuthCredential(
            accessToken: authResponse.accessToken ?? "",
            requestToken: authResponse.refreshToken ?? ""
        )
    }
}
