//
//  logo.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
                .frame(height: 20) // Equivalent to android:layout_marginTop="20dp"
            
            Image("logo_artandwords") // Use the name of your image asset
                .resizable()
                .frame(width: 150, height: 111) // Equivalent to android:layout_width and android:layout_height
                .scaledToFit() // Equivalent to android:adjustViewBounds="true"
                .accessibilityLabel(Text(NSLocalizedString("app_name", comment: ""))) // Equivalent to android:contentDescription

            Spacer()
                .frame(height: 40) // Equivalent to android:layout_marginBottom="40dp"
        }
        .frame(maxWidth: .infinity, alignment: .center) // Equivalent to android:layout_width="match_parent" and android:gravity="center"
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewLayout(.sizeThatFits)
    }
}
