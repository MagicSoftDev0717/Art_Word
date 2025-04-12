//
//  spinner_item.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct AWTextView: View {
    var body: some View {
        Text("This is an XML file containing a vector graphic definition for use in Android development. It appears to represent a complex SVG-like path structure designed to render specific shapes or illustrations.") // Replace with the desired text
            .font(.system(size: 45)) // Equivalent to android:textSize="15sp"
            .foregroundColor(Color.black) // Equivalent to android:textColor="#000000"
            .multilineTextAlignment(.leading) // Equivalent to android:gravity="left"
            .padding(5) // Equivalent to android:padding="5dip"
    }
}

struct AWTextView_Previews: PreviewProvider {
    static var previews: some View {
        AWTextView()
            .previewLayout(.sizeThatFits)
    }
}
