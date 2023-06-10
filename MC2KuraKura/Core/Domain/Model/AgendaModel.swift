//
//  Agenda.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 01/06/23.
//

import Foundation

struct Voter: Codable , Equatable{
    private enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case firstName = "firstName"
        case value = "value"
    }
    let userId: String?
    let firstName: String?
    let value: Int?
}

struct AgendaModel: Codable, Equatable, Identifiable {
    private enum CodingKeys: String, CodingKey{
        case id = "id"
        case proposerID = "proposerID"
        case firstName = "firstName"
        case title =  "title"
        case description = "description"
        case result = "result"
        case voters = "voters"
    }
    
    let id: String
    let proposerID: String
    let firstName: String
    let title: String
    let description: String
    let result: Double
    let voters: [Voter]
    
    init(id: String, proposerID: String, firstName: String, title: String, description: String) {
        self.id = id
        self.proposerID = proposerID
        self.firstName = firstName
        self.title = title
        self.description = description
        self.result = 0
        self.voters = []
    }
    
    
    init(id: String, proposerID: String, firstName: String, title: String, description: String, result: Double, voters: [Voter]) {
        self.id = id
        self.proposerID = proposerID
        self.firstName = firstName
        self.title = title
        self.description = description
        self.result = result
        self.voters = voters
  
    }
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
    static let sharedExample3 = AgendaModel(
        id: UUID().uuidString,
        proposerID: UserModel.sharedExample.id,
        firstName: UserModel.sharedExample.firstName,
        title: "Menentukan Kantor",
        description: "Mendiskusikan harga, persyaratan kontrak, waktu pengiriman, dan faktor-faktor lain yang berkaitan dengan kesepakatan penjualan"
    )
}
