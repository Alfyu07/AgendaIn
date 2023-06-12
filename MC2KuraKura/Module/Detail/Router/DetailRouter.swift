//
//  DetailRouter.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 03/06/23.
//

import SwiftUI

class DetailRouter {
    func makeVoteView(for meeting: MeetingModel) -> some View {
        let voteUseCase = Injection.init().provideVote(for: meeting)
        let presenter = VotePresenter(voteUsecase: voteUseCase)
        return VoteView(presenter: presenter)
    }
    
    func makeDetailView(for meeting: MeetingModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(for: meeting)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return ResultDetailView(presenter: presenter)
    }
}
