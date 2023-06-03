//
//  RemoteDataSource.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//
// Data source atau sumber data biasanya berisi logic pemanggilan data entah dari api atau dari db

import Foundation

protocol RemoteDataSourceProtocol: AnyObject {
    func getAllMeetings(result: @escaping (Result<[MeetingModel], URLError>) -> Void)
    func login(result: @escaping (Result<UserModel, URLError>) -> Void)
}

final class RemoteDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func login(result: @escaping (Result<UserModel, URLError>) -> Void) {
        
    }
    
    func getAllMeetings(result: (Result<[MeetingModel], URLError>) -> Void) {

    }
    
}
