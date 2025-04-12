//
//  animation.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct AnimationView: View {
    var body: some View {
        HStack {
            Image("image1") // Image equivalent of ImageView
                .resizable()
                .scaledToFit() // Adjust the scaling of the image
                .frame(width: 100, height: 100) // You can adjust size here as per your requirement
        }
        .frame(maxWidth: .infinity) // To match the "fill_parent" for width
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
