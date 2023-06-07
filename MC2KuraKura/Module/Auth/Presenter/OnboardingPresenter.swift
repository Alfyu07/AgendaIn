//
//  LoginViewPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 30/05/23.
//

import SwiftUI
import AuthenticationServices

class OnboardingPresenter: ObservableObject {
    
    private let router = OnboardingRouter()
    private let onboardingUseCase: OnboardingUseCase
    
    init(onBoardingUseCase: OnboardingUseCase) {
        self.onboardingUseCase = onBoardingUseCase
    }
    
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    @Published var index = 0
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    
    // swiftlint: disable line_length
    @Published var onboardingTexts: [OnboardingTextModel] = [
        OnboardingTextModel(
            id: UUID().uuidString,
            titleText: "Collaborative",
            descriptionText: "We will create the meeting agenda together,\nCollaboration and thoughts will merge,\nIdeas will emerge, concepts will be formed,\nSo that this meeting is successful and focused."
        ),
        OnboardingTextModel(
            id: UUID().uuidString,
            titleText: "Positive Impact",
            descriptionText: "With a structured and open meeting agenda,\nTogether, we create a productive gathering,\nTogether, we move forward and grow,\nGenerating a positive impact for our team and organization."
        ),
        OnboardingTextModel(
            id: UUID().uuidString,
            titleText: "Effective and Efficient",
            descriptionText: "Consider efficient and realistic timing,\nSo that each topic can be discussed thoroughly,\nAllocate time for discussion and collaboration,\nAs well as for effective decision-making."
        )
    ]
    
    // swiftlint: enable line_length
    func linkBuilder<Content: View>(
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(destination: router.makeMainView()) { content() }
    }
    
    func autoScroll() {
        DispatchQueue.main.async {
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                if self.index < 2 {
                    self.index += 1
                } else {
                    self.index = 0
                }
            }
        }
        
    }
    
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
            
            let authRequest = AuthRequest(validateCode: token, firstName: firstName ?? "John", lastName: lastName ?? "Doe")
            print(authRequest)
            
            onboardingUseCase.signUp(request: authRequest) { result in
                switch result {
                case .success(let authCredential):
                    DispatchQueue.main.async {
                        self.accessToken = authCredential.accessToken
                        self.refreshToken = authCredential.refreshToken
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                      self.loadingState = false
                      self.errorMessage = error.localizedDescription
                      print(error.localizedDescription)
                    }
                }
                
            }
            
            // Fix this
//            send(token: token, firstName: firstName ?? "Zulfadhli", lastName: lastName ?? "")
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
