//
//  setting.swift
//  art_words_v1.0
//
//  Created by My iMac on 9/2/2025.
//

import SwiftUI

extension UIViewController {
    func getNavigationController() -> UINavigationController? {
        if let navController = self as? UINavigationController {
            return navController
        }
        return self.navigationController ?? self.presentedViewController?.getNavigationController()
    }
}

struct SettingsView: View {
    // Persistent storage using @AppStorage
    @AppStorage("musicType") private var musicType = "Instrumental"
    @AppStorage("splashEnabled") public var splashEnabled = true
    @AppStorage("fontSize") private var fontSize = 35
    @AppStorage("typewriterEffectEnabled") private var typewriterEffectEnabled = true
    @AppStorage("typewriterSpeed") private var typewriterSpeed = 0.2
    //    @AppStorage("selectedLanguage") private var selectedLanguage = LanguageManager.shared.currentLanguage
    @AppStorage("idLanguage") public var idLanguage = 2
    @AppStorage("notificationReminder") private var notificationReminder = 1
    @AppStorage("randomNotificationsEnabled") private var randomNotificationsEnabled = false
    
    @State private var selectedSpeed = UserDefaults.standard.string(forKey: "speed") ?? "0.2"
    @ObservedObject var languageManager = LanguageManager.shared
    
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text( LanguageManager.shared.localizedString(forKey: "pref_category_general") )) {
                        Picker( LanguageManager.shared.localizedString(forKey: "pref_music") , selection: $musicType) {
                            ForEach([ LanguageManager.shared.localizedString(forKey: "music_no_music") ,  LanguageManager.shared.localizedString(forKey: "music_instrumental") ,  LanguageManager.shared.localizedString(forKey: "music_voice") ,   LanguageManager.shared.localizedString(forKey: "music_instrumental_voice") ], id: \.self) { value in
                                Text("\(value)").tag(value)
                            }
                        }
                        
                        Toggle( LanguageManager.shared.localizedString(forKey: "pref_splash") , isOn: $splashEnabled)
                        
                        //                    Picker("Font Size", selection: $fontSize) {
                        //                        ForEach(["Small", "Medium", "Large"], id: \.self) { value in
                        //                            Text("\(value)").tag(value)
                        //                        }
                        //                    }
                        Picker( LanguageManager.shared.localizedString(forKey: "pref_fontsize") , selection: $fontSize) {
                            ForEach(Array(zip(AppSettings.fontSizeTexts, AppSettings.fontSizeValues)), id: \.1) { text, value in
                                Text(text).tag(value)
                            }
                        }
                    }
                    
                    Section(header: Text( LanguageManager.shared.localizedString(forKey: "pref_category_texteffects") )) {
                        Toggle( LanguageManager.shared.localizedString(forKey: "pref_typewritereffect") , isOn: $typewriterEffectEnabled)
                        
                        //                    Picker("Typewriter Speed", selection: $typewriterSpeed) {
                        //                        ForEach(["Slow", "Normal", "Fast"], id: \.self) { value in
                        //                            Text("\(value)").tag(value)
                        //                        }
                        //                    }
                        Picker( LanguageManager.shared.localizedString(forKey: "pref_typewriterspeed") , selection: $typewriterSpeed) {
                            ForEach(Array(zip(AppSettings.typewriterSpeedTexts, AppSettings.typewriterSpeedValues)), id: \.1) { text, value in
                                Text(text).tag(value)
                            }
                        }
                    }
                    
                    Section(header: Text( LanguageManager.shared.localizedString(forKey: "pref_language") )) {
                        Picker( LanguageManager.shared.localizedString(forKey: "pref_category_language") , selection: $languageManager.selectedLanguage) {
                            ForEach(AppLanguage.allCases, id: \.self) { lang in
                                Text(lang.displayName).tag(lang.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: languageManager.selectedLanguage) { newLang in
                            languageManager.changeLanguage(to: newLang)
                            switch newLang {
                            case "en":
                                idLanguage = 2
                            case "ca":
                                idLanguage = 1
                            case "es":
                                idLanguage = 3
                            default:
                                idLanguage = 2
                            }
                            //                        reloadApp()
                        }
                    }
                    
                    Section(header: Text( LanguageManager.shared.localizedString(forKey: "pref_category_notifications") )) {
                        Picker( LanguageManager.shared.localizedString(forKey: "pref_newinspiration_notification") , selection: $notificationReminder) {
                            ForEach(Array(zip(AppSettings.notificationTexts, AppSettings.notificationValues)), id: \.1) { text, value in
                                Text(text).tag(value)
                            }
                        }
                        
                        Toggle( LanguageManager.shared.localizedString(forKey: "pref_randomnotifications") , isOn: $randomNotificationsEnabled)
                    }
                }
                .navigationTitle( LanguageManager.shared.localizedString(forKey: "menu_settings") )
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
