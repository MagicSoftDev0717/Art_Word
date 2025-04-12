//
//  LanguageManager.swift
//  art_words_v1.0
//
//  Created by TopDev on 27/2/2025.
//

import Foundation

public class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
	    @Published var selectedLanguage: String = UserDefaults.standard.string(forKey: "appLanguage") ?? "en"

    func localizedString(forKey key: String) -> String {
        guard let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return key
        }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    
    func changeLanguage(to language: String) {
        selectedLanguage = language
        UserDefaults.standard.set(language, forKey: "appLanguage")
        objectWillChange.send() // Notify SwiftUI to update views
    }
}
