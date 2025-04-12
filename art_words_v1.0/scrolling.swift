//
//  scrolling.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct ScrollingView: View {
    var body: some View {
        ScrollView {
            VStack {
                // Your content goes here, you can add more Views like Text, Image, etc.
                Text("This is inside a scroll view")
                    .font(.largeTitle)
                    .padding()
                
                // Add more content here as needed
                ForEach(0..<30) { index in
                    Text("Item \(index)")
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(5)
                        .padding(.bottom, 5)
                }
            }
            .padding() // Padding for the whole VStack content
        }
        .background(Color.white) // Set a background color if needed
    }
}

struct ScrollingView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingView()
    }
}
