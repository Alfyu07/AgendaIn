//
//  Stepper.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

struct CustomStepper: View {
    let stepNumber: Int
    let steps: [String]
    @Binding var stepIndex: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color("gray40"))
                .frame(height: 3)
                .padding(.top, 6.5)
                .padding(.horizontal)
            
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(0..<stepNumber) { index in
                    VStack(alignment: .center, spacing: 0) {
                        Circle()
                            .fill(index == stepIndex ? Color("blue50") : Color("gray50"))
                            .frame(width: 16, height: 16)
                        Text(steps[index])
                            .frame(width: 48, height: 32, alignment: .top)
                            .font(.system(size: 12, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(index == stepIndex ? Color("blue50") : Color("gray50"))
                            .padding(.top, 8)
                    }
                    if index != stepNumber - 1 {
                        Spacer()
                    }
                }
            }
            
        }
    }
    
}

