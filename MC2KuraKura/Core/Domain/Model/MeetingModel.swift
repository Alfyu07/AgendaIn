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

struct MeetingModel: Equatable, Identifiable {
    let id: String
    let title: String
    let description: String
    let code: String
    let location: String
    let date: Date
    let startTime: Date
    let endTime: Date
    let votingDate: Date
    let votingStartTime: Date
    let votingEndTime: Date
    let participants: [UserModel]
    let proposedAgendas: [Agenda]
    let status: VoteStatus
    
    static let sharedExample = MeetingModel(
        id: UUID().uuidString,
        title: "Pengajuan Proposal Pada Perusahaan",
        description: "Rapat ini bertujuan untuk mengidentifikasi kebutuhan perusahaan, mengevaluasi solusi yang ditawarkan, dan mengkomunikasikan nilai tambah dari proposal penjualan.",
        code: "2345",
        location: "Aula Bersama",
        date: Date.now,
        startTime: Date.now - 5000,
        endTime: Date.now + 5000,
        votingDate: Date.now,
        votingStartTime: Date.now + 2000,
        votingEndTime: Date.now + 4000,
        participants: [.sharedExample, .sharedExample2],
        proposedAgendas: [.sharedExample, .sharedExample2],
        status: .open
    )
    static let sharedExample2 = MeetingModel(
        id: UUID().uuidString,
        title: "Pengajuan Proposal Pada Perusahaan",
        description: "Rapat ini bertujuan untuk mengidentifikasi kebutuhan perusahaan, mengevaluasi solusi yang ditawarkan, dan mengkomunikasikan nilai tambah dari proposal penjualan.",
        code: "2455",
        location: "Aula Bersama",
        date: Date.now,
        startTime: Date.now - 1000,
        endTime: Date.now + 1000,
        votingDate: Date.now,
        votingStartTime: Date.now + 2000,
        votingEndTime: Date.now + 4000,
        participants: [.sharedExample, .sharedExample2],
        proposedAgendas: [.sharedExample, .sharedExample2],
        status: .open
    )
}
