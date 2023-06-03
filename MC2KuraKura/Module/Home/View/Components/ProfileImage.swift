//
//  ProfileImage.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct ProfileImage: View {
    let imgUrlString: String
    let size: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imgUrlString)) { image in
            image
                .resizable()
                .frame(width: size, height: size)
                .scaledToFit()
                .clipShape(Circle())
        } placeholder: {
           Color("gray50")
                .frame(width: size, height: size)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        }
    }
    
}
