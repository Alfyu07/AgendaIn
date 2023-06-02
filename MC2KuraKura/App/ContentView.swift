//
//  ContentView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 29/05/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var onboardingPresenter: OnboardingPresenter
    var body: some View {
        NavigationStack {
            OnboardingView(presenter: onboardingPresenter)
//            CodeTextField(numberOfFields: 4)
        }.fontDesign(.rounded)
    }
}
