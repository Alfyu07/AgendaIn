//
//  MeetingView.swift
//  MC2KuraKura
//
//  Created by Wahyu Alfandi on 04/06/23.
//

import SwiftUI

struct MeetingView: View {
    @ObservedObject var presenter: MeetingPresenter
    @Binding var index: Int
    var body: some View {
        
        NavigationLink(destination: presenter.addMeetingView()) {
            Text("Add Meeting")
        }
    }
}
