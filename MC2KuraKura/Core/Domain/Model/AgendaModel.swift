//
//  Agenda.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 01/06/23.
//

import Foundation

struct AgendaModel: Codable, Equatable, Identifiable {
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case proposerID = "proposerID"
        case firstName = "firstName"
        case title =  "title"
        case description = "description"
    }
    
    let id: String
    let proposerID: String
    let firstName: String
    let title: String
    let description: String
    
    static let sharedExample = AgendaModel(
        id: UUID().uuidString,
        proposerID: UserModel.sharedExample.id,
        firstName: UserModel.sharedExample.firstName,
        title: "Menentukan Perusahaan",
        description: "Mendiskusikan harga, persyaratan kontrak, waktu pengiriman, dan faktor-faktor lain yang berkaitan dengan kesepakatan penjualan"
    )
    static let sharedExample2 = AgendaModel(
        id: UUID().uuidString,
        proposerID: UserModel.sharedExample.id,
        firstName: UserModel.sharedExample.firstName,
        title: "Menentukan Anggaran",
        description: "Mendiskusikan harga, persyaratan kontrak, waktu pengiriman, dan faktor-faktor lain yang berkaitan dengan kesepakatan penjualan"
    )
    
}
