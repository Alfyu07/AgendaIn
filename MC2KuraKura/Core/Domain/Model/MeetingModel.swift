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
    let location: String
    let date: Date
    let startTime: Date
    let endTime: Date
    let participants: [UserModel]
    let status: VoteStatus
    
    static let sharedExample = MeetingModel(
        id: UUID().uuidString,
        title: "Menentukan Tema",
        description: "Rapat ini bertujuan untuk mengidentifikasi kebutuhan perusahaan, mengevaluasi solusi yang ditawarkan, dan mengkomunikasikan nilai tambah dari proposal penjualan.",
        location: "Aula Bersama",
        date: Date.now,
        startTime: Date.now,
        endTime: Date.now,
        participants: [.sharedExample, .sharedExample, .sharedExample, .sharedExample, .sharedExample], status: .open
    )
}
