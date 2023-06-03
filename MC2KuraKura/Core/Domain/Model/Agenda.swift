//
//  Agenda.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 01/06/23.
//

import Foundation

struct Agenda: Equatable, Identifiable {
    
    static func == (lhs: Agenda, rhs: Agenda) -> Bool {
       return lhs.id == rhs.id && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.proposer == rhs.proposer
    }
    
    let id: String
    let title: String
    let description: String
    let proposer: UserModel
    
    static let sharedExample = Agenda(
        id: UUID().uuidString,
        title: "Menentukan Perusahaan",
        description: "Mendiskusikan harga, persyaratan kontrak, waktu pengiriman, dan faktor-faktor lain yang berkaitan dengan kesepakatan penjualan",
        proposer: .sharedExample2
    )
    static let sharedExample2 = Agenda(
        id: UUID().uuidString,
        title: "Menentukan Anggaran",
        description: "Mendiskusikan harga, persyaratan kontrak, waktu pengiriman, dan faktor-faktor lain yang berkaitan dengan kesepakatan penjualan",
        proposer: .sharedExample2
    )
    
}
