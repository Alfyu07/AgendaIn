//
//  MeetingView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 04/06/23.
//

import SwiftUI

struct MeetingView: View {
    @StateObject var presenter: MeetingPresenter
    var body: some View {
        presenter.linkBuilder {
            Text("Add Meeting")
        }
    }
}
