//
//  settingValue.swift
//  art_words_v1.0
//
//  Created by TopDev on 26/2/2025.
//

import Foundation

struct AppSettings {
    
    static let languageTexts = ["English", "Español", "Català"]
    static let languageValues = ["en", "es", "ca"]

    static var typewriterSpeedTexts: [String] {
        return [
            LanguageManager.shared.localizedString(forKey: "speed_slow"),
            LanguageManager.shared.localizedString(forKey: "speed_normal"),
            LanguageManager.shared.localizedString(forKey: "speed_fast")
        ]
    }
    static let typewriterSpeedValues = [0.3, 0.2, 0.1]

    static let soundTexts = ["on", "off"]

    static var fontSizeTexts: [String] {
        return [
            LanguageManager.shared.localizedString(forKey: "size_small"),
            LanguageManager.shared.localizedString(forKey: "size_medium"),
            LanguageManager.shared.localizedString(forKey: "size_large")
        ]
    }

    static let fontSizeValues = [30, 35, 45]

    static var notificationTexts: [String] {
        return [
            LanguageManager.shared.localizedString(forKey: "reminder_never"),
            LanguageManager.shared.localizedString(forKey: "reminder_once_a_day"),
            LanguageManager.shared.localizedString(forKey: "reminder_once_a_week"),
            LanguageManager.shared.localizedString(forKey: "reminder_twice_a_week"),
            LanguageManager.shared.localizedString(forKey: "reminder_once_a_month"),
            LanguageManager.shared.localizedString(forKey: "reminder_twice_a_month")
        ]
    }

    static let notificationValues = [0, 1, 2, 3, 4, 5]

    static let fontTexts = [
        "amerika_sans", "apantasia", "arabolical", "centabel",
        "fontlero", "korean_calligraphy", "lovitz",
        "quigleyw_wiggly", "times_sans_serif"
    ]
    static let fontValues = fontTexts // Values are identical to names

    static let menuItems = [
        "Settings", "Share This App", "Drop Me a Line",
        "How To Use Art & Words", "Open Inspiration", "About Art & Words"
    ]

    static let musicTexts = ["No Music", "Instrumental", "Voice", "Instrumental + Voice"]
    static let musicValues = [0, 1, 2, 3]
}
