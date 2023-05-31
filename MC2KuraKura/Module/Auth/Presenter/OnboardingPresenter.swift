//
//  LoginViewPresenter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 30/05/23.
//

import Foundation

class OnboardingPresenter: ObservableObject {
       
    private let router = OnboardingRouter()
    private let onboardingUseCase: OnboardingUseCase
    
    init(onBoardingUseCase: OnboardingUseCase) {
        self.onboardingUseCase = onBoardingUseCase
    }
    
    @Published var index = 0
    
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
}
