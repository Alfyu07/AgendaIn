//
//  OnboardingRouter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 31/05/23.
//

import SwiftUI

class OnboardingRouter {
    func makeHomeView() -> some View {
        let homeUseCase = Injection.init().provideHome()
        let presenter = HomePresenter(homeUseCase: homeUseCase)
        return HomeView(presenter: presenter)
    }
}
