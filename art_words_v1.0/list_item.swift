//
//  list_item.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct DrawerMenuItemView: View {
    var iconName: String
    var menuText: String

    var body: some View {
        HStack(spacing: 10) {
            // Menu Item Icon
            Image("image1") // Replace with your asset name
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50) // Fixed width like android:layout_width="50dp"
                .padding(.leading, 10) // Equivalent to android:layout_marginStart="10dp"

            // Menu Item Text
            Text(menuText)
                .font(.system(size: 15)) // Equivalent to android:textSize="15sp"
                .foregroundColor(Color.black) // Equivalent to android:textColor="#000"
                .frame(maxWidth: .infinity, alignment: .leading) // Fill remaining space
                .padding(.trailing, 16) // Equivalent to android:paddingEnd="16dp"
                .padding(.leading, 10) // Equivalent to android:paddingStart="10dp"
                .background(Color.blue) // For activatedBackgroundIndicator, customize here if needed
        }
        .frame(height: 60) // Equivalent to android:layout_height="60dp"
    }
}

struct DrawerMenuItemView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerMenuItemView(iconName: "menu_icon", menuText: "Menu Item") // Replace with your asset name
            .previewLayout(.sizeThatFits)
    }
}
