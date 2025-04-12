//
//  actionbar.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//
import SwiftUI

struct ActionbarView: View {
    var body: some View {
        HStack {
            // Logo FrameLayout equivalent (llLogo)
            Spacer() // Helps align logo to the left
            VStack {
                // Logo Image
                Image("ic_logo") // Replace with your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 113, height: 31)
                    .accessibility(label: Text("Logo"))
            }
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity) // To simulate weight for the logo frame
            
            // Menu icon and Title FrameLayout equivalent (llMenuIcon)
            HStack {
                // Action Bar Title (AutoResizeTextView equivalent)
                Text("Action Bar Title") // Replace with dynamic title as needed
                    .font(.system(size: 22))
                    .foregroundColor(Color(hex: "#0D0D0D"))
                    .lineLimit(1) // Equivalent to singleLine="true"
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Menu Icon Image
                Image("menu_icon_white") // Replace with your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 20)
                    .padding(.top, 10)
            }
            .frame(maxHeight: .infinity) // Align vertically in parent container
            .padding(.trailing, 20) // Padding for the end (right side)
        }
        .padding(.horizontal, 20) // PaddingStart and PaddingEnd equivalent
        .background(Color.blue) // Clear background color
    }
}

struct ActionbarView_Previews: PreviewProvider {
    static var previews: some View {
        ActionbarView()
    }
}
