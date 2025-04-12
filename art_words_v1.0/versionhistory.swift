//
//  aboutapp.swift
//  art_words_v1.0
//
//  Created by My iMac on 9/2/2025.
//

import SwiftUI

struct VersionHistoryView: View {
    @State private var textContent = ""

    var body: some View {
        ScrollView {
            Text(textContent)
                .padding()
        }
        .onAppear {
            loadTextFile()
        }
    }

    func loadTextFile() {
        // Locate the file in the bundle
        if let fileURL = Bundle.main.url(forResource: "changelog_en", withExtension: "txt") {
            do {
                // Load the file contents into a string
                let contents = try String(contentsOf: fileURL, encoding: .utf8)
                textContent = contents
            } catch {
                print("Error loading file: \(error.localizedDescription)")
                textContent = "Failed to load file."
            }
        } else {
            print("File not found")
            textContent = "File not found."
        }
    }
}

struct VersionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        VersionHistoryView()
    }
}
