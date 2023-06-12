//
//  RemoteDataSource.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//
// Data source atau sumber data biasanya berisi logic pemanggilan data entah dari api atau dari db

import Foundation
import SwiftUI

protocol RemoteDataSourceProtocol: AnyObject {
    func getAllMeetings(result: @escaping (Result<[MeetingModel], URLError>) -> Void)
    func signUp(request: AuthRequest, result: @escaping (Result<AuthResponse, URLError>) -> Void)
    func shareMeeting(result: @escaping (Result<AuthResponse, URLError>) -> Void)
    func getProfile(result: @escaping (Result<GetUserResponse, URLError>) -> Void)
    func addMeeting(request: AddMeetingRequest, result: @escaping (Result<MeetingResponse, URLError>) -> Void)
    func getMeetingById(request: GetMeetingRequest, result: @escaping (Result<MeetingResponse, URLError>) -> Void)
    func getMeetingByUserId(result: @escaping (Result<[GetMeetingByUserIDResponse]?, URLError>) -> Void)
    func joinMeetingByCode(request: JoinMeetingRequest, result: @escaping (Result<MeetingResponse, URLError>) -> Void)
    func addMeetingAgenda(request: AddAgendaRequests, result: @escaping (Result<MeetingResponse, URLError>) -> Void)
    func addVotesAgenda(request: AddVoteAgendas, result: @escaping (Result<MeetingResponse, URLError>) -> Void)
    func saveResultAgendaChanges(request: SaveResultAgendasChangesRequest,
                                 result: @escaping (Result<MeetingResponse, URLError>) -> Void)
}

final class RemoteDataSource: NSObject, URLSessionDelegate {
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func saveResultAgendaChanges(request: SaveResultAgendasChangesRequest, result: @escaping (Result<MeetingResponse, URLError>) -> Void) {
        guard let meetingCode = try? JSONEncoder().encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.agendaResult.url) else {return}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: meetingCode) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(MeetingResponse.self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
            } else if  let response = maybeResponse as? HTTPURLResponse, response.statusCode == 400 {
                result(.failure(.noDataFound))
            }
        }
        task.resume()
    }
    
    func addVotesAgenda(request: AddVoteAgendas, result: @escaping (Result<MeetingResponse, URLError>) -> Void) {
        guard let meetingCode = try? JSONEncoder().encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.vote.url) else {return}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: meetingCode) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(MeetingResponse.self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
            } else if  let response = maybeResponse as? HTTPURLResponse, response.statusCode == 400 {
                result(.failure(.noDataFound))
            }
        }
        task.resume()
    }
    
    func addMeetingAgenda(request: AddAgendaRequests, result: @escaping (Result<MeetingResponse, URLError>) -> Void) {
        guard let meetingCode = try? JSONEncoder().encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.agenda.url) else {return}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: meetingCode) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(MeetingResponse.self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
            } else if  let response = maybeResponse as? HTTPURLResponse, response.statusCode == 400 {
                result(.failure(.noDataFound))
            }
        }
        task.resume()
    }
    
    func joinMeetingByCode(request: JoinMeetingRequest, result: @escaping (Result<MeetingResponse, URLError>) -> Void) {
        guard let meetingCode = try? JSONEncoder().encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.joinMeeting.url) else {return}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: meetingCode) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(MeetingResponse.self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
            } else if  let response = maybeResponse as? HTTPURLResponse, response.statusCode == 400 {
                result(.failure(.noDataFound))
            }
        }
        task.resume()
    }
    
    func getMeetingByUserId(result: @escaping (Result<[GetMeetingByUserIDResponse]?, URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.meetings.url) else {return}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: urlRequest) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode([GetMeetingByUserIDResponse].self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    
    func getMeetingById(request: GetMeetingRequest, result: @escaping (Result<MeetingResponse, URLError>) -> Void) {
        guard let meetingData = try? JSONEncoder().encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.meetingId.url) else {return}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: meetingData) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(MeetingResponse.self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    
    func getProfile(result: @escaping (Result<GetUserResponse, URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.user.url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: urlRequest) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(GetUserResponse.self, from: data)
                    result(.success(user))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getAllMeetings(result: (Result<[MeetingModel], URLError>) -> Void) {
        
    }
    
    func addMeeting(request: AddMeetingRequest, result: @escaping (Result<MeetingResponse, URLError>) -> Void) {
        guard let meetingData = try? JSONEncoder().encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.meeting.url) else {return}
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: meetingData) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let data = try decoder.decode(MeetingResponse.self, from: data)
                    result(.success(data))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume() 
    }
    
    func signUp(
        request: AuthRequest,
        result: @escaping (Result<AuthResponse, URLError>) -> Void
    ) {
        
        guard let authData = try? JSONEncoder()
            .encode(request) else {return}
        
        guard let url = URL(string: Endpoints.Gets.signup.url) else { return }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, from: authData) { maybeData, maybeResponse, error in
            
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                
                do {
                    let token = try decoder.decode(AuthResponse.self, from: data)
                    result(.success(token))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
        
        
        //        let task = URLSession.shared.uploadTask(with: url, from: authData) { maybeData, maybeResponse, maybeError in
        //          if maybeError != nil {
        //            result(.failure(.addressUnreachable(url)))
        //          } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
        //            let decoder = JSONDecoder()
        //            do {
        //              let categories = try decoder.decode(CategoriesResponse.self, from: data).categories
        //
        //              result(.success(categories))
        //            } catch {
        //              result(.failure(.invalidResponse))
        //            }
        //          }
        //        }
        //        task.resume()
    }
    
    func shareMeeting(result: @escaping (Result<AuthResponse, URLError>) -> Void) {
        
        //        guard let url = URL(string: Endpoints.Gets.share.url) else {return}
        //        var urlRequest = URLRequest(url: url)
        //
        //        urlRequest.httpMethod = "POST"
        //        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //
        //        let task = URLSession.shared.dataTask(with: urlRequest){ maybeData, maybeResponse, error in
        //            if error != nil {
        //                result(.failure(.addressUnreachable(url)))
        //            } else if let data = maybeData, let response =  maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
        //                let decoder = JSONDecoder()
        //
        //                do {
        //                    // MARK : Just template
        //                    let token = try decoder.decode(AuthResponse.self, from: data)
        //                    result(.success(token))
        //                } catch {
        //                    result(.failure(.invalidResponse))
        //                }
        //            }
        //            task.resume()
    }
    
    
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
}


