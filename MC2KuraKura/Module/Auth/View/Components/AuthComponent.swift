//
//  ContentView.swift
//  featureTesting
//
//  Created by Enzu Ao on 28/05/23.
//

import SwiftUI
import AuthenticationServices


struct AppleLoginButton: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        
        SignInWithAppleButton(.continue,
                              onRequest: loginViewModel.handle(request:),
                              onCompletion: loginViewModel.handle(completion:))
        .signInWithAppleButtonStyle(
            colorScheme == .dark ? .white : .black
        )
        .frame(height: 50)
        .padding()
        .cornerRadius(8)
    }
}



class HomeViewModel: ObservableObject {
    @Published var id: String = ""
    
//    func fetch(accessToken: String) {
//        guard let url = URL(string: "")
//    }
    
}

final class LoginViewModel: ObservableObject {
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    func handle(request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func handle(completion result: Result<ASAuthorization, Error>) {
//        switch result {
//        case .success(let auth):
//            switch auth.credential {
//            case let credential as ASAuthorizationAppleIDCredential:
//
//                let userId = credential.user
//
//                let email = credential.email
//                let firstName = credential.fullName?.givenName
//                let lastName = credential.fullName?.familyName
//
//                print(userId)
//
//            default:
//                break
//            }
//        case .failure(let error):
//            print(error)
//        }
        switch result {
        case .success(let auth):
            guard let credential = auth.credential as? ASAuthorizationAppleIDCredential,
                  let tokenData = credential.authorizationCode,
                  let token = String(data: tokenData, encoding: .utf8)
            else { print("error credential login"); return}
            let firstName = credential.fullName?.givenName
            let lastName = credential.fullName?.familyName
            send(token: token, firstName: firstName ?? "Zulfadhli", lastName: lastName ?? "")
        case .failure(let error):
            print(error)
        }
    }
    
    private func send(token: String, firstName: String, lastName: String) {
        guard let authData = try? JSONEncoder()
            .encode(["validateCode": token,
                     "firstName": firstName,
                     "lastName": lastName])
        else {return}
        
        let url = URL(string: "http://192.168.1.6:8000/signup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: authData) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SignupResponse.self, from: data)
                print(response)
                self.accessToken = response.accessToken
                self.refreshToken = response.refreshToken
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

struct SignupResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
