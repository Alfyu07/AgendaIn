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
    
    func signUp(request: AuthRequest, result: @escaping (Result<AuthResponse, URLError>) -> Void)
}

final class RemoteDataSource: NSObject, URLSessionDelegate {
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getAllMeetings(result: (Result<[MeetingModel], URLError>) -> Void) {
        
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
            
            if(error != nil) {
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
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

