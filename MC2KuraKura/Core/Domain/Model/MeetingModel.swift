//
//  Meeting.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import Foundation

struct MeetingModel: Equatable, Identifiable {
    let id: String
    let title: String
    let description: String
    var participant: [String]
    
}
