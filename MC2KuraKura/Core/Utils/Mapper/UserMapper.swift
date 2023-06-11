//
//  UserMapper.swift
//  MC2KuraKura
//
//  Created by Enzu Ao on 07/06/23.
//

import Foundation

final class UserMapper {
    static func mapGetUserResponseToDomain(input getUserResponse: GetUserResponse) -> UserModel {
        
        return UserModel(
            id: getUserResponse.id ?? "",
            firstName: getUserResponse.firstName ?? "",
            lastName: getUserResponse.lastName ?? "",
            email: getUserResponse.email ?? ""
        )
    }
}
