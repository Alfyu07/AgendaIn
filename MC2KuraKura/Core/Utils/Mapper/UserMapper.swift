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
            email: getUserResponse.email ?? "",
            role: UserRole.participant,
            imgUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=988&q=80"
        )
    }
}
