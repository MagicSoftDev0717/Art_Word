//
//  art_words_v1_0App.swift
//  art_words_v1.0
//
//  Created by My iMac on 19/1/2025.
//

import SwiftUI

import Core
import Repository
import Service
import SpotifyiOS

@main
struct art_words_v1_0App: App {
    init() {
        setupDefaultLanguage()
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        
    var body: some Scene {
        WindowGroup {
            FirstView()
                .onAppear {
                    AppDelegate.orientationLock = .portrait
                }
                .onDisappear {
                    AppDelegate.orientationLock = .all
                }
//                .environmentObject(makeFetchDataUseCase())
        }
    }
    
    func setupDefaultLanguage() {
        let storedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage")
        
        if storedLanguage == nil {
            let defaultLanguage: AppLanguage = .english  // Set your preferred default
            LanguageManager.shared.changeLanguage(to: defaultLanguage.rawValue) // Ensures SwiftUI updates
        }
    }
}

struct FirstView: View {
    // Read the persisted splash setting from UserDefaults
    @AppStorage("splashEnabled") var splashEnabled: Bool = true

    // Local state to control when to transition
    @State private var showSplash = true

    var body: some View {
        Group {
            if splashEnabled && showSplash {
                SplashView()
            } else {
                DashboardView()
            }
        }
        .onAppear {
            // If splash is enabled, show it for a few seconds, then transition
            if splashEnabled {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showSplash = false
                    }
                }
            } else {
                // If splash is not enabled, immediately transition to DashboardView
                showSplash = false
            }
        }
    }
}
