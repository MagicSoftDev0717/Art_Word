//
//  AppLanguage.swift
//  art_words_v1.0
//
//  Created by TopDev on 27/2/2025.
//

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case spanish = "es"
    case catalan = "ca"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .spanish: return "Español"
        case .catalan: return "Català"
        }
    }
}


