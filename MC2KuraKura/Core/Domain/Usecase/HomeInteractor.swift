//
//  HomeInteractor.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 02/06/23.
//

import Foundation

protocol HomeUseCase {
    func joinMeeting(code: String)
}

class HomeInteractor: HomeUseCase {
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func joinMeeting(code: String) {
        
    }
}
