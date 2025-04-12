//
//  custiomdialog_accept.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct CustomDialogAcceptView: View {
    var body: some View {
        VStack(spacing: 1) {
            // Title Section
            VStack(spacing: 0) {
                // Title Text
                Text("Dialog Title") // Replace with dynamic title
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                
                // Divider below the title
                Divider()
                    .frame(height: 1.5)
                    .background(Color.white)
            }

            // Text Content Section
            VStack(spacing: 0) {
                Text("Dialog Content") // Replace with dynamic content
                    .font(.system(size: 20))
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Divider below the content
                Divider()
                    .frame(height: 1)
                    .background(Color.white)
            }

            // Button Section
            VStack {
                Button(action: {
                    // Action for accept button
                }) {
                    Text("Accept") // Replace with dynamic button text
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(6)
                }
                .padding(.top, 6)
            }
        }
        .frame(width: 300) // Container width
        .background(Color(hex: "#f6c61a")) // Background color of the container
        .cornerRadius(10) // Optional: Rounded corners for a smoother look
        .padding() // Optional: Padding around the dialog container
    }
}

struct CustomDialogAcceptView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialogAcceptView()
    }
}
