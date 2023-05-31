//
//  MC2KuraKuraApp.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//

import SwiftUI

@main
struct MC2KuraKuraApp: App {
    let onboardingPresenter = OnboardingPresenter(onBoardingUseCase: Injection.init().provideOnboarding())
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(onboardingPresenter)
        }
    }
}
