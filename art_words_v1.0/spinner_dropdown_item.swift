//
//  spinner_dropdown_item.swift
//  art_words_v1.0
//
//  Created by My iMac on 21/1/2025.
//

import SwiftUI

struct SpinnerDropDownItem: View {
    var text: String = "Sample Text" // Replace with dynamic text if needed
    
    var body: some View {
        Text(text)
            .font(.system(size: 18)) // Equivalent to `android:textSize="18sp"`
            .foregroundColor(Color.gray.opacity(0.5)) // Equivalent to `android:textColor="#808080"`
            .lineLimit(1) // Equivalent to `android:singleLine="true"`
            .truncationMode(.middle) // Equivalent to `android:ellipsize="marquee"`
            .frame(maxWidth: .infinity, minHeight: 44, alignment: .leading) // Match `match_parent` width and preferred item height
            .padding(.horizontal) // Add padding for better spacing
    }
}

struct SpinnerDropDownItem_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerDropDownItem()
            .previewLayout(.sizeThatFits)
    }
}
