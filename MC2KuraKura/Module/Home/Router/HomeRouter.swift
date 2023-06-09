//
//  HomeRouter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 02/06/23.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for meeting: MeetingModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(for: meeting)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
    func makeReviewView(for meeting: MeetingModel) -> some View {
        let reviewUseCase = Injection.init().provideReview(for: meeting)
        let presenter = ReviewPresenter(useCase: reviewUseCase)
        return ReviewView(presenter: presenter)
    }
}
