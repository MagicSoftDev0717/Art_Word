//
//  splash.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // Image view equivalent to ImageView in Android XML
            Image("splash_back") // Replace with your image name
                .resizable()
//                .scaledToFit()
                .ignoresSafeArea() // Extends the image to fill the safe
//                .accessibility(label: Text("Splash")) // Equivalent to android:contentDescription
                .zIndex(1)
            AnimatedImage(name: "fairy.gif") // Replace with your GIF file name
                            .resizable()
                            .scaledToFit() // Keep the GIF's aspect ratio
//                            .frame(width: 200, height: 200) // Adjust the size of the GIF
                            .zIndex(2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Equivalent to match_parent for both width and height
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewLayout(.sizeThatFits)
    }
}
