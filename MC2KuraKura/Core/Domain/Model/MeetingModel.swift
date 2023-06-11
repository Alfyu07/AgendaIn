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

class MeetingModel: Equatable, Identifiable, ObservableObject {
    static func == (lhs: MeetingModel, rhs: MeetingModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.picID == rhs.picID &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.code == rhs.code &&
        lhs.location == rhs.location &&
        lhs.schedule == rhs.schedule &&
        lhs.voteTime == rhs.voteTime &&
        lhs.participants == rhs.participants &&
        lhs.proposedAgendas == rhs.proposedAgendas &&
        lhs.status == rhs.status
    }
    
    @Published var id: String
    @Published var picID: PICID
    @Published var title: String
    @Published var description: String
    @Published var code: String
    @Published var location: String
    @Published var schedule: MeetingTime
    @Published var voteTime: MeetingTime
    @Published var participants: [UserModel]
    @Published var proposedAgendas: [AgendaModel]
    @Published var status: VoteStatus
    
    init(id: String, picID: PICID, title: String, description: String, code: String, location: String, schedule: MeetingTime, voteTime: MeetingTime, participants: [UserModel], proposedAgendas: [AgendaModel], status: VoteStatus) {
        self.id = id
        self.picID = picID
        self.title = title
        self.description = description
        self.code = code
        self.location = location
        self.schedule = schedule
        self.voteTime = voteTime
        self.participants = participants
        self.proposedAgendas = proposedAgendas
        self.status = status
    }
    
    init(){
        self.id = ""
        self.picID = PICID(userID: "", firstName: "")
        self.title = ""
        self.description = ""
        self.code = ""
        self.location = ""
        self.schedule = MeetingTime(date: Date(), startTime: Date(), endTime: Date())
        self.voteTime = MeetingTime(date: Date(), startTime: Date(), endTime: Date())
        self.participants = []
        self.proposedAgendas = []
        self.status = .open
    }
    
    func changeTheMeetingModel(id: String, picID: PICID, title: String, description: String, code: String, location: String, schedule: MeetingTime, voteTime: MeetingTime, participants: [UserModel], proposedAgendas: [AgendaModel], status: VoteStatus) {
        self.id = id
        self.picID = picID
        self.title = title
        self.description = description
        self.code = code
        self.location = location
        self.schedule = schedule
        self.voteTime = voteTime
        self.participants = participants
        self.proposedAgendas = proposedAgendas
        self.status = status
    }
    
    
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
