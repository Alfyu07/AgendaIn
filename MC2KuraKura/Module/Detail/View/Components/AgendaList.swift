//
//  AgendaList.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct AgendaList: View {
    let proposedAgendas: [AgendaModel]
    let width: Double
    var body: some View {
        VStack(spacing: 0) {
            ForEach(proposedAgendas) { agenda in
                    AgendaItem(agenda: agenda, isOnVote: false, isOnResult: false, width: width)
                    .padding(.bottom, 12)
            }
        }
    }
}
