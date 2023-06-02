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
}
