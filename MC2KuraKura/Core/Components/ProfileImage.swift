//
//  ProfileImage.swift
//  MC2KuraKura
//
//  Created by Wahu Alfandi on 07/06/23.
//

import SwiftUI

struct ProfileImage: View {
    let firstName: String
    let size: CGFloat
    
    var body: some View {
        Circle().fill().overlay {
            Text(firstName.prefix(1)).font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }.frame(width: size, height: size)
    }
    
}


struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(firstName: UserModel.sharedExample.firstName, size: 24)
    }
}
