//
//  actionbar_nomenu.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct ActionbarNomenuView: View {
    var body: some View {
        HStack {
            // Back Button (AWButton equivalent)
            Button(action: {
                // Action for back button
            }) {
                Image("back_arrow") // Replace with your asset name
                    .resizable()
                    .frame(width: 22, height: 16)
                    .padding(.horizontal, 6)
            }
            .background(Color.clear) // Ensures no background color
            .buttonStyle(PlainButtonStyle()) // Disables button style if any

            Spacer()

            // Title TextView equivalent (AutoResizeTextView)
            Text("Action Bar Title")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .lineLimit(1) // Equivalent to singleLine="true"
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 10) // PaddingStart and PaddingEnd equivalent
        .background(Color.blue) // Ensure no background color
    }
}

struct ActionbarNomenuView_Previews: PreviewProvider {
    static var previews: some View {
        ActionbarNomenuView()
    }
}
