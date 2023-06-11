//
//  CodeTextFIeld.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 02/06/23.
//

import SwiftUI

struct CodeTextField: View {
    let numberOfFields: Int
    @Binding var codeValue: [String]
    @State var oldValue = ""
    @FocusState private var fieldFocus: Int?
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfFields, id: \.self) { index in
                VStack(spacing: 0) {
                    TextField("", text: $codeValue[index], onEditingChanged: { editing in
                        if editing {
                            oldValue = codeValue[index]
                        }
                    })
                        .keyboardType(.asciiCapable)
                        .frame(width: 30, height: 40)

                        .multilineTextAlignment(.center)
                        .focused($fieldFocus, equals: index)
                        .tag(index)
                        .onChange(of: codeValue[index]) { newValue in
                            if !newValue.isEmpty {
                                // Update to new value if there is already an value.
                                if codeValue[index].count > 1 {
                                    let currentValue = Array(codeValue[index])
                                    
                                    if currentValue[0] == Character(oldValue) {
                                        codeValue[index] = String(codeValue[index].suffix(1))
                                    } else {
                                        codeValue[index] = String(codeValue[index].prefix(1))
                                    }
                                }
                                
                                // MARK: - Move to Next
                                if index == numberOfFields-1 {
                                    fieldFocus = nil
                                } else {
                                    fieldFocus = (fieldFocus ?? 0) + 1
                                }
                            } else {
                                // MARK: - Move back
                                fieldFocus = (fieldFocus ?? 0) - 1
                            }
                        }
                    Divider()
                        .frame(width: 30, height: 2)
                        .background(Color("blue90"))
                        .offset(CGSize(width: 0, height: -8))
                }
            }
        }
    }

}
