//
//  RemoteDataSource.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//

import Foundation

protocol RemoteDataSourceProtocol: AnyObject {
    func getAllMeetings()
}

final class RemoteDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getAllMeetings() {
        // code implementation here
    }
}
