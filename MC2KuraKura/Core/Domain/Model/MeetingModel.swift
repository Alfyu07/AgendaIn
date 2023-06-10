//
//  Meeting.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

enum VoteStatus: String {
    case open = "Open"
    case closed = "Closed"
}

struct PICID: Codable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case userID = "userID"
        case firstName = "firstName"
    }
    let userID: String
    let firstName: String
    
    static let sharedExample = PICID(userID: UserModel.sharedExample.id, firstName: UserModel.sharedExample.firstName)
    static let sharedExample2 = PICID(userID: UserModel.sharedExample2.id, firstName: UserModel.sharedExample2.firstName)
}

struct MeetingModel: Equatable, Identifiable {
    let id: String
    let picID: PICID
    let title: String
    let description: String
    let code: String
    let location: String
    let schedule: MeetingTime
    let voteTime: MeetingTime
    let participants: [UserModel]
    var proposedAgendas: [AgendaModel]
    let status: VoteStatus
    
    static let sharedExample = MeetingModel(
        id: UUID().uuidString,
        picID: .sharedExample,
        title: "Pengajuan Proposal Pada Perusahaan",
        description: "Rapat ini bertujuan untuk mengidentifikasi kebutuhan perusahaan, mengevaluasi solusi yang ditawarkan, dan mengkomunikasikan nilai tambah dari proposal penjualan.",
        code: "2345",
        location: "Aula Bersama",
        schedule: .scheduleExample,
        voteTime: .voteTimeExample,
        participants: [.sharedExample, .sharedExample2],
        proposedAgendas: [.sharedExample, .sharedExample2, .sharedExample3],
        status: .open
    )
    static let sharedExample2 = MeetingModel(
        id: UUID().uuidString,
        picID: .sharedExample2,
        title: "Pengajuan Proposal Pada Perusahaan",
        description: "Rapat ini bertujuan untuk mengidentifikasi kebutuhan perusahaan, mengevaluasi solusi yang ditawarkan, dan mengkomunikasikan nilai tambah dari proposal penjualan.",
        code: "2455",
        location: "Aula Bersama",
        schedule: .scheduleExample,
        voteTime: .voteTimeExample,
        participants: [.sharedExample, .sharedExample2],
        proposedAgendas: [.sharedExample, .sharedExample2, .sharedExample3],
        status: .open
    )
    
}
