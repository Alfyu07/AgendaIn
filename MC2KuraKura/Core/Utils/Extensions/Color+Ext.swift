//
//  Color+Ext.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//

import SwiftUI

extension Color {
  static var random: Color {
    return Color(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1)
    )
  }
}
