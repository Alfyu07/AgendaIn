//
//  NotificationView.swift
//  MC2KuraKura
//
//  Created by Nindya Alita Rosalia on 08/06/23.
//

import SwiftUI

struct NotificationView: View {
    @StateObject var presenter = NotificationPresenter()
    var body: some View {
        VStack (alignment: .leading){
            Text("Today")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("gray50"))
                .padding(.leading, 28)
                .padding(.bottom, 12)
            
            
            ForEach(presenter.notifications) { notification in
                HStack {
                    Circle()
                        .fill(Color.random)
                        .frame(width: 70, height: 70)
                        .overlay {
                            Image("illustration3")
                                .resizable()
                                .scaledToFit()
                        }
                    
                    VStack(alignment: .leading) {
                        Text(notification.title)
                            .font(.system(size: 12, weight: .bold))
                        Text(notification.meetingTitle)
                            .font(.system(size: 11, weight: .regular))
                        Text(notification.description)
                            .font(.system(size: 10, weight: .regular))
                    }
                    Button(action: {
                        // Tindakan yang akan dijalankan saat tombol ditekan
                    }) {
                        Text("Vote")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("blue50"))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color("blue95"))
                            .cornerRadius(5)
                    }
                }
                .padding(.horizontal, 22)
            }
        }
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
