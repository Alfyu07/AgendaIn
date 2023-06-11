//
//  ProfilePresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 11/06/23.
//

import SwiftUI

class ProfilePresenter: ObservableObject {
    private let userUsecase: UserUseCase
    
    @Published var loadingState: Bool = true
    @Published var errorMessage: String = ""
    @Published var firstName: String = ""
    
    @AppStorage("accessToken") var accessToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    init(userUsecase: UserUseCase) {
        self.userUsecase = userUsecase
    }
    
    func getProfile() {
        loadingState = true
        userUsecase.getProfile { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    print("user ID : \(user.id)")
                    print("access token : \(self.accessToken)")
                    self.firstName = user.firstName
                    self.loadingState = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.loadingState = false
                }
            }
        }
    }
    
    func logout() {
        loadingState = true
        DispatchQueue.main.async {
            self.accessToken = ""
            self.refreshToken = ""
            self.loadingState = false
        }
    }
}
