//
//  NotificationModel.swift
//  MC2KuraKura
//
//  Created by Nindya Alita Rosalia on 08/06/23.
//

import Foundation


struct NotificationModel: Equatable, Identifiable{
    let id: String
    let title: String
    let meetingTitle: String
    let description: String
    let createdDate: Date
    
    static let sharedExample = NotificationModel(id: UUID().uuidString, title: "The voting time has been opened.", meetingTitle: "Pengajuan Proposal Perusahaan", description: "The voting will be closed on June 21, 2023 | 20.00", createdDate: Date.now)
    static let sharedExample2 = NotificationModel(id: UUID().uuidString, title: "There are 5 minutes left for voting.", meetingTitle: "Pengajuan Proposal Perusahaan", description: "The voting will be closed on June 21, 2023 | 20.00", createdDate: Date.now + 86400)
}
