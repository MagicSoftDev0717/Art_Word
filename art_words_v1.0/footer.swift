//
//  footer.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct DrawerFooterView: View {
    var body: some View {
        HStack(alignment: .top) { // Horizontal orientation with top alignment
            Text("Footer Text") // Replace with dynamic text
                .font(.system(size: 13))
                .foregroundColor(Color.black.opacity(0.99)) // Equivalent to #000100
                .frame(maxWidth: .infinity, maxHeight: 80, alignment: .top) // Match dimensions and alignment
                .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10)) // Equivalent padding
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Parent container alignment
        .background(Color(red: 0, green: 255, blue: 0))
    }
}

struct DrawerFooterView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerFooterView()
    }
}
