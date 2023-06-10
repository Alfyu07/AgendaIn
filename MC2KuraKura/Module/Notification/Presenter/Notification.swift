//
//  Notification.swift
//  MC2KuraKura
//
//  Created by Nindya Alita Rosalia on 08/06/23.
//

import Foundation

class NotificationPresenter: ObservableObject{
    
    @Published var notifications : [NotificationModel] = [.sharedExample, .sharedExample2]
    
    init() {
        
    }
}
