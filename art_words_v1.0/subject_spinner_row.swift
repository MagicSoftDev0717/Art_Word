//
//  subject_spinner_row.swift
//  art_words_v1.0
//
//  Created by My iMac on 21/1/2025.
//

import SwiftUI

struct SubjectLayout: View {
    var subjectText: String = "Sample Subject" // Replace with dynamic text if needed
    
    var body: some View {
        HStack {
            Text(subjectText)
                .font(.system(size: 18)) // Equivalent to `android:textSize="18sp"`
                .foregroundColor(Color.gray.opacity(0.5)) // Equivalent to `android:textColor="#808080"`
                .padding(.top, 10) // Equivalent to `android:paddingTop="10dp"`
                .padding(.leading, 10) // Equivalent to `android:paddingLeft="10dp"`
                .padding(.trailing, 10) // Equivalent to `android:paddingRight="10dp"`
                .padding(.bottom, 10) // Equivalent to `android:paddingBottom="10dp"`
                .frame(maxWidth: .infinity, alignment: .leading) // Equivalent to `android:layout_width="match_parent"`
        }
        .frame(maxWidth: .infinity) // Equivalent to `fill_parent`
    }
}

struct SubjectLayout_Previews: PreviewProvider {
    static var previews: some View {
        SubjectLayout()
            .previewLayout(.sizeThatFits)
    }
}
