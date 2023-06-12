//
//  ProgressBar.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 09/06/23.
//

import SwiftUI

struct ProgressBar: View {
    let width: Double
    let value: Double
  
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color("gray5"))
                .frame(maxWidth: width)
            Rectangle()
                .fill(Color("yellow50"))
                .frame(maxWidth: width * value)
        }.frame(height: 20)
            .cornerRadius(30)
            .padding(.top, 4)
            .onAppear{
                print(value)
            }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(width: 240, value: 0.3)
    }
}
