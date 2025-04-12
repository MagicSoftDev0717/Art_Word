//
//  fragmentitemlist.swift
//  art_words_v1.0
//
//  Created by My iMac on 21/1/2025.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
}

struct ItemFragmentView: View {
    let items: [Item] = [
        Item(title: "Item 1"),
        Item(title: "Item 2"),
        Item(title: "Item 3"),
        // Add more items as needed
    ]
    
    var body: some View {
        List(items) { item in
            HStack {
                Text(item.title)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                Spacer()
            }
            .padding(.vertical, 5)
        }
        .listStyle(PlainListStyle()) // Matches the look of RecyclerView
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white) // Optional: Add background
        .navigationTitle("Dashboard Items") // Optional: Title of the list
    }
}

struct ItemView: View {
    var body: some View {
        NavigationView {
            ItemFragmentView()
        }
    }
}

struct ItemFragmentView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
