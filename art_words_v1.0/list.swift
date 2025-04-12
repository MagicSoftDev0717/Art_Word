//
//  list.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct RightDrawerView: View {
    var body: some View {
        List {
            // Add your list items here
            Text("Item 1")
            Text("Item 2")
            Text("Item 3")
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .trailing) // Set width as per your dimension
        .background(Color(UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1))) // Equivalent to #ffeeeeee
        .edgesIgnoringSafeArea(.vertical) // Ensures the List takes the full height
    }
}

struct RightDrawerView_Previews: PreviewProvider {
    static var previews: some View {
        RightDrawerView()
            .previewLayout(.sizeThatFits)
    }
}
