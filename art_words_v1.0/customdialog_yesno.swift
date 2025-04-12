//
//  customdialog_yesno.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct CustomDialogYesnoView: View {
    var body: some View {
        VStack {
            // Main container with custom border
            VStack(spacing: 1) {
                // Title Section
                VStack(spacing: 0) {
                    // Title Text
                    Text("Dialog Title") // Replace with dynamic title
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    
                    // Divider below the title
                    Divider()
                        .frame(height: 0.35)
                        .background(Color.black)
                }
                
                // Dialog Text Section
                VStack(spacing: 0) {
                    Text("Dialog Content") // Replace with dynamic content
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Divider below the content
                    Divider()
                        .frame(height: 0.35)
                        .background(Color.black)
                }
                
                // Button Section
                HStack(spacing: 10) {
                    // Yes Button
                    Button(action: {
                        // Action for "Yes" button
                    }) {
                        Text("Yes") // Replace with dynamic text
                            .font(.system(size: 15))
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(5)
                    }
                    
                    // No Button
                    Button(action: {
                        // Action for "No" button
                    }) {
                        Text("No") // Replace with dynamic text
                            .font(.system(size: 15))
                            .padding(.vertical, 5)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(5)
                    }
                }
                .padding(.top, 6)
                .padding([.leading, .trailing], 5)
            }
            .padding(1)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1) // Simulating custom border
            )
        }
        .frame(width: 280) // Container width
    }
}

struct CustomDialogYesnoView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialogYesnoView()
    }
}
