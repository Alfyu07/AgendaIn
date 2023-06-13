//
//  ProgressBar.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 09/06/23.
//

import SwiftUI

struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: 20)
                    .foregroundColor(Color("gray5"))

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 20)
                        .foregroundColor(Color("yellow50"))
            }.cornerRadius(30)
                .padding(.top, 4)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.3)
    }
}
