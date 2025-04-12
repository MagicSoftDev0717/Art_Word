//
//  save_spinner_row.swift
//  art_words_v1.0
//
//  Created by My iMac on 21/1/2025.
//

import SwiftUI

struct SaveLayoutView: View {
    var body: some View {
        HStack {
            Text("Save") // Replace with dynamic text if needed
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .frame(maxWidth: .infinity, alignment: .leading) // Match `match_parent`
        }
        .frame(maxWidth: .infinity) // Match `fill_parent`
    }
}

struct SaveLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        SaveLayoutView()
            .previewLayout(.sizeThatFits)
    }
}
