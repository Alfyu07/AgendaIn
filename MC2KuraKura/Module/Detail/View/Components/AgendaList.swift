//
//  AgendaList.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

struct AgendaList: View {
    let proposedAgendas: [AgendaModel]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(proposedAgendas) { agenda in
                    AgendaItem(agenda: agenda)
                    .padding(.bottom, 12)
            }
        }
    }
}

struct AgendaList_Previews: PreviewProvider {
    static var previews: some View {
        AgendaList(proposedAgendas: [.sharedExample, .sharedExample2])
    }
}
