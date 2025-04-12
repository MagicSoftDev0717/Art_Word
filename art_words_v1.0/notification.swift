//
//  notification.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct DetailedNotificationView: View {
    var body: some View {
        VStack {
            Text("Hi, Your Detailed notification view goes here....") // Equivalent to android:text
                .frame(maxWidth: .infinity) // Equivalent to android:layout_width="match_parent"
                .frame(height: 400) // Equivalent to android:layout_height="400dp"
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Equivalent to android:layout_width="match_parent" and android:layout_height="match_parent"
    }
}

struct DetailedNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedNotificationView()
            .previewLayout(.sizeThatFits)
    }
}
