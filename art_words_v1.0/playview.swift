//
//  playview.swift
//  art_words_v1.0
//
//  Created by My iMac on 23/1/2025.
//

import SwiftUI
import UIKit
import AVFoundation
import SpotifyiOS
import Service

import WebKit
import SDWebImageSwiftUI
import Combine

import ReplayKit
import Photos

import Foundation
import AVKit

import ImageIO
import MobileCoreServices

public class MyAudioPlayerManager: ObservableObject {
    public static let shared = MyAudioPlayerManager()
    public var player: AVPlayer?
    public var currentAudioFileURL: URL?

    public func playPreview(from url: URL, musicName: String, completion: @escaping (Bool) -> Void) {
        let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(musicName).mp3")
        downloadAudio(from: url, to: tempFileURL) { success in
            if success {
                self.currentAudioFileURL = tempFileURL
                AudioPlayerManager.shared.playPreview(from: tempFileURL.absoluteString)
                completion(true)
            } else {
                completion(false)
                
            }
        }
    }

    public func downloadAudio(from url: URL, to destinationURL: URL, completion: @escaping (Bool) -> Void) {
        URLSession.shared.downloadTask(with: url) { location, response, error in
            guard let location = location, error == nil else {
                completion(false)
                return
            }
            try? FileManager.default.moveItem(at: location, to: destinationURL)
            completion(true)
        }.resume()
    }

    public func play() {
        player?.play()
    }

    public func seekToStart() {
        player?.seek(to: .zero)
    }
    
    public func stop() {
        AudioPlayerManager.shared.stopPreview()
        currentAudioFileURL = nil // Clear the stored file URL
    }
}

struct ScreenshotView: SwiftUI.View {
    @Binding public var inspiration: String
    @Binding public var imageUrl: String
    @Binding public var imageHeight: CGFloat // Store the height dynamically
    @Binding public var imageWidth: CGFloat
    @Binding public var image_enable : Bool
    @Binding public var text_enable : Bool
    @Binding public var typewriterEffectEnabled : Bool
    @Binding var selectedGifName: String

    @ObservedObject var languageManager: LanguageManager
    
    @Binding public var isButtonActive: Bool
    @Binding public var musicUrl: String
    @Binding public var musicName: String
    
    @State private var sendtoEmail: String = ""
    
    var body: some SwiftUI.View {
        
        VStack() {
        ZStack {
            if image_enable == true {
                if let url = URL(string: imageUrl)  {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .padding(.top, 60)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
//                            .offset(y: -50)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
 
                                        .onAppear {
//                                                                backImage = image
                                            imageHeight = geometry.size.height
                                            imageWidth = geometry.size.width
//                                            isimageload = true
                                        }
                                }
                            )
                    } placeholder: {
                        ProgressView() // Placeholder while the image loads
                    }
                } else {
                    Text("Image not available")
                        .foregroundColor(.gray)
                }
            }

                AnimatedImage(name: selectedGifName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: max(0, imageWidth - 40), height: max(0, imageHeight - 60)) // Control frame size
                //                                    .scaleEffect(3)              // Scale GIF proportionally
                    .cornerRadius(10)
                    .allowsHitTesting(false)
                    .offset(y: 30)
                    .zIndex(3)
            
//            if text_enable == true {
//                ZStack {
//                    TypingEffectView(fullText: inspiration, show: typewriterEffectEnabled)
//                        .frame(maxWidth: .infinity, alignment: .center)
//                    //                .opacity(0) // Start invisible
//                        .onAppear {
//                            withAnimation(.easeIn(duration: 0.5)) {
//                                // Make the typewriter text visible
//                            }
//                        }
//                }
//                .padding(.leading, 10)
//                .padding(.trailing, 0)
//            }
            
            if text_enable == true {
                if isButtonActive == true {
                    ZStack {
                        TypewriterText(text: inspiration, show: typewriterEffectEnabled, Height: imageHeight)
                            .frame(maxWidth: .infinity, alignment: .center)
                        //                .opacity(0) // Start invisible
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    // Make the typewriter text visible
                                }
                            }
                    }
                    .padding(.top, 60)
                    .padding(.leading, 10)
                    .padding(.trailing, 0)
                } else {
                    ZStack {
                        TypewriterText(text: inspiration, show: false, Height: imageHeight)
                            .frame(maxWidth: .infinity, alignment: .center)
                        //                .opacity(0) // Start invisible
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    // Make the typewriter text visible
                                }
                            }
                    }
                    .padding(.top, 60)
                    .padding(.leading, 10)
                    .padding(.trailing, 0)
                }
            }
        }
        
        // Signature Section
            VStack(spacing: 5) {
                HStack {
                    Text( languageManager.localizedString(forKey: "painting_signature_title") )
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.black)
                    if !isButtonActive {
                        NavigationLink(destination: ReportProblemView(musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, sendtoEmail: $sendtoEmail)) {
                            Text("Amvi")
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .underline(color: .blue)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            sendtoEmail = "amvironi12375@gmail.com"
                        })
                    } else {
                        Text("Amvi")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }
                HStack {
                    Text( languageManager.localizedString(forKey: "inspiration_signature_title") )
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.black)
                    if !isButtonActive {
                        NavigationLink(destination: ReportProblemView(musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, sendtoEmail: $sendtoEmail)) {
                            Text("Diego Esteban Pérez")
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .underline(color: .blue)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            sendtoEmail = "diegopefm@gmail.com"
                        })
                    } else {
                        Text("Diego Esteban Pérez")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }
                HStack {
                    Text( languageManager.localizedString(forKey: "track_details_title") )
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.black)
                    if !isButtonActive {
                        Link(destination: URL(string: "https://open.spotify.com/track/\(musicUrl)")! ) {
                            Text(musicName)
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .underline(color: .blue)
                        }
                    } else {
                        Text(musicName)
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
                }
                Text( languageManager.localizedString(forKey: "app_copyright") )
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
//        .offset(y: imageHeight / 2 + 40)
    }
}

struct PlayView: SwiftUI.View {
    
    @Binding public var musicUrl: String
    @Binding public var musicName: String
    
    @State private var showMenu = false
    @State public var effect_enable = false
    
    @State private var previewUrl: String? = nil
    @State private var token: String?
    
    @Binding public var inspiration: String
    @Binding public var imageUrl: String
//    @Binding public var backImage: Image
    @Binding public var imageHeight: CGFloat // Store the height dynamically
    @Binding public var imageWidth: CGFloat
    @State public var image_enable = true
    @State public var text_enable = true
    @State private var ScreenshotView_enable: Bool = false
    
    @AppStorage("typewriterEffectEnabled") private var typewriterEffectEnabled = true
    
    @State public var showShareSheet = false
    @State public var showShareSheet_v = false
    @State public var showShareSheet_t = false
    @State public var showShareSheet_p = false
    @State public var capturedImage: UIImage?
    
    @ObservedObject var languageManager = LanguageManager.shared
    
    @State private var timer: Timer?
    @State private var screenshots: [UIImage] = []
    @StateObject private var audioPlayer = MyAudioPlayerManager.shared
    @State private var isButtonActive = true
    @State public var isbackhidden = false
    @AppStorage("typewriterSpeed") private var typewriterSpeed = 0.2
    @State private var selectedGifName: String = "anim0.gif"
    
    @State private var issave: Bool = false
    @State private var isshare: Bool = false
    
    @State public var toastText: String = ""
    @State public var showToast = false
    @Binding public var isCapture: Bool
    
    @State private var frameIndex = 0

    var body: some SwiftUI.View {
        ZStack {
            if issave {
                VStack {
                    Spacer() // Pushes content to the top
                    
                    ProgressView("Saving")
                        .tint(Color(hex: "#5AAE9E")) // Progress color
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(Color(hex: "#5AAE9E")) // Set text color
                        .font(.headline) // Set font size
                        .padding(.bottom, 60) // Adjust bottom padding
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Color.black.opacity(0.5)) // Optional: Add background overlay
                .zIndex(5)
            }
            
            if isshare {
                VStack {
                    Spacer() // Pushes content to the top
                    
                    ProgressView("Sharing")
                        .tint(Color(hex: "#5AAE9E")) // Progress color
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(Color(hex: "#5AAE9E")) // Set text color
                        .font(.headline) // Set font size
                        .padding(.bottom, 60) // Adjust bottom padding
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Color.black.opacity(0.5)) // Optional: Add background overlay
                .zIndex(5)
            }
            
            Color.white.ignoresSafeArea()
            VStack {
                DrawerTitleView(showMenu: $showMenu, isButtonActive: $isButtonActive, isbackhidden: $isbackhidden, musicUrl: $musicUrl, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, musicName: $musicName)
                if !showMenu{
                    Spacer()
                }
            }
            .zIndex(2)
            
            ZStack {
                
                VStack{
                Spacer()
                
                // Video Layout
                if !ScreenshotView_enable {
                    VStack(spacing: 20) {
                        Text("Loading...")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    .padding(20)
                }
                
                // Inspiration Layout
                if ScreenshotView_enable {
                    ScreenshotView(
                        inspiration: $inspiration,
                        imageUrl: $imageUrl,
                        imageHeight: $imageHeight,
                        imageWidth: $imageWidth,
                        image_enable: $image_enable,
                        text_enable: $text_enable,
                        typewriterEffectEnabled: $typewriterEffectEnabled,
                        selectedGifName: $selectedGifName,
                        languageManager: languageManager,
                        isButtonActive: $isButtonActive,
                        musicUrl: $musicUrl,
                        musicName: $musicName
                    )
                    .onAppear{
                        if isButtonActive {
                            startScreenCapturing()
                        }
                    }
                }
                
                    Spacer()
                    
                    
                    // Bottom Menu
                    HStack(spacing: 35) {
                        if !isButtonActive {
                            Menu {
                                Button(action: {
                                    // Action for first item
//                                    let musicUrlValue = $musicUrl.wrappedValue
//                                    let musicNameValue = $musicName.wrappedValue
//                                    let inspirationValue = $inspiration.wrappedValue
//                                    let imageUrlValue = $imageUrl.wrappedValue
//                                    let imageHeightValue = $imageHeight.wrappedValue
//                                    let imageWidthValue = $imageWidth.wrappedValue
//                                    let imageEnableValue = $image_enable.wrappedValue
//                                    let textEnableValue = $text_enable.wrappedValue
//                                    let typewriterEffectEnabledValue = $typewriterEffectEnabled.wrappedValue
//                                    let selectedGifNameValue = $selectedGifName.wrappedValue
//                                    let languageManagerValue = languageManager
//                                    
//                                    let text = "\(musicUrlValue),\n \(musicNameValue),\n \(inspirationValue),\n \(imageUrlValue),\n \(imageHeightValue),\n \(imageWidthValue),\n \(imageEnableValue),\n \(textEnableValue),\n \(typewriterEffectEnabledValue),\n \(selectedGifNameValue),\n \(languageManagerValue)"
//                                    let formatter = DateFormatter()
//                                    formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss" // Example: 2025-03-09_14-45-30
//                                    let timestamp = formatter.string(from: Date())
//                                    let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("artandwords_\(timestamp).aw")
//                                    do {
//                                        try text.write(to: tempFileURL, atomically: true, encoding: .utf8)
                                    let imageID = DB_Manager().getImageIDbyURL(url: imageUrl) ?? 0
                                    let musicID = DB_Manager().getMusicIDbyURL(url: musicUrl) ?? 0
                                    let inspirationID = DB_Manager().getInspirationIDbyText(inspiration: inspiration) ?? 0
                                    
                                    let text = "ArtAndWords:\(inspirationID)@\(imageID)@\(musicID)"
                                    
                                    let encryptedText = CryptoManager.encrypt(text)
                                    
                                    // Getting the URL of the Documents directory
                                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                                        // Creating the full URL by appending the text file name
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss" // Example: 2025_03_09_14_45_30
                                        let timestamp = formatter.string(from: Date())
                                        let tempFileURL = FileManager.default.temporaryDirectory.appendingPathComponent("artandwords_\(timestamp).aw")
                                        
                                        do {
                                            // Writing the text to the file
                                            try encryptedText!.write(to: tempFileURL, atomically: true, encoding: String.Encoding.utf8)
                                            let activityViewController = UIActivityViewController(activityItems: [tempFileURL], applicationActivities: nil)
                                            
                                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                               let rootViewController = windowScene.windows.first?.rootViewController {
                                                rootViewController.present(activityViewController, animated: true, completion: nil)
                                            }
                                        } catch {
                                            print("Failed to create file for sharing: \(error)")
                                        }
                                    }
                                }) {
                                    Text("Share Art&Words File")
                                }
                                
                                Button(action: {
                                    // Action for second item
                                    isshare = true
                                    if selectedGifName != "anim0.gif" {
                                        let gifName = selectedGifName.replacingOccurrences(of: ".gif", with: "")

                                        DispatchQueue.global(qos: .userInitiated).async {
                                            if let gifFrames = extractFramesFromGIF(named: gifName) {
                                                overlayGIFFramesOnScreenshots(gifFrames: gifFrames)
                                            }

                                            // Once processing is done, switch back to the main thread
                                            DispatchQueue.main.async {
                                                self.generateVideoWithAudio()
                                            }
                                        }
                                    } else {
                                        self.generateVideoWithAudio()
                                    }
                                }) {
                                    Text("Share video")
                                }
                                Button(action: {
                                    // Action for third item
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        captureScreenshot () { image in
                                            if let image = image {
                                                self.capturedImage = image
                                                self.showShareSheet = true
                                            } else {
                                                print("Failed to capture image.")
                                            }
                                        }
                                    }
                                }) {
                                    Text("Share screenshot")
                                }
                            } label: {
                                Image("share_icon")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.gray)
                            }
                            .sheet(isPresented: Binding(
                                get: { showShareSheet },
                                set: { showShareSheet = $0 }
                            )) {
                                ShareSheet(activityItems: [capturedImage!])
                            }
                        } else {
                            Image("share_icon_disable")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.gray)
                        }
                        
                        if !isButtonActive {
                            Menu {
                                Button(action: {
                                    // Action for first item
                                    let imageID = DB_Manager().getImageIDbyURL(url: imageUrl) ?? 0
                                    let musicID = DB_Manager().getMusicIDbyURL(url: musicUrl) ?? 0
                                    let inspirationID = DB_Manager().getInspirationIDbyText(inspiration: inspiration) ?? 0
                                    
                                    let text = "ArtAndWords:\(inspirationID)@\(imageID)@\(musicID)"
                                    
                                    let encryptedText = CryptoManager.encrypt(text)
                                    
                                    // Getting the URL of the Documents directory
                                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                                        // Creating the full URL by appending the text file name
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss" // Example: 2025_03_09_14_45_30
                                        let timestamp = formatter.string(from: Date())
                                        let fileURL = documentsDirectory.appendingPathComponent("artandwords_\(timestamp).aw")
                                        
                                        do {
                                            // Writing the text to the file
                                            try encryptedText!.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                                            print("Successfully wrote text to file at \(fileURL)")
                                            toastText = "Inspiration has been saved in Files."
                                            showToast = true
                                        } catch {
                                            // Handle the error
                                            print("An error occurred: \(error)")
                                        }
                                    }
                                    
//                                    let musicUrlValue = $musicUrl.wrappedValue
//                                    let musicNameValue = $musicName.wrappedValue
//                                    let inspirationValue = $inspiration.wrappedValue
//                                    let imageUrlValue = $imageUrl.wrappedValue
//                                    let imageHeightValue = $imageHeight.wrappedValue
//                                    let imageWidthValue = $imageWidth.wrappedValue
//                                    let imageEnableValue = $image_enable.wrappedValue
//                                    let textEnableValue = $text_enable.wrappedValue
//                                    let typewriterEffectEnabledValue = $typewriterEffectEnabled.wrappedValue
//                                    let selectedGifNameValue = $selectedGifName.wrappedValue
//                                    let languageManagerValue = languageManager
//                                    
//                                    let text = "\(musicUrlValue),\n \(musicNameValue),\n \(inspirationValue),\n \(imageUrlValue),\n \(imageHeightValue),\n \(imageWidthValue),\n \(imageEnableValue),\n \(textEnableValue),\n \(typewriterEffectEnabledValue),\n \(selectedGifNameValue),\n \(languageManagerValue)"
//                                    
//                                    // Getting the URL of the Documents directory
//                                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                                        // Creating the full URL by appending the text file name
//                                        let formatter = DateFormatter()
//                                        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss" // Example: 2025_03_09_14_45_30
//                                        let timestamp = formatter.string(from: Date())
//                                        let fileURL = documentsDirectory.appendingPathComponent("artandwords_\(timestamp).aw")
//                                        
//                                        do {
//                                            // Writing the text to the file
//                                            try text.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
//                                            print("Successfully wrote text to file at \(fileURL)")
//                                            toastText = "Inspiration has been saved in Files."
//                                            showToast = true
//                                        } catch {
//                                            // Handle the error
//                                            print("An error occurred: \(error)")
//                                        }
//                                    }
                                    
                                }) {
                                    Text("Save to watch later")
                                }
                                .disabled(isButtonActive)
                                
                                Button(action: {
                                    issave = true
                                    if selectedGifName != "anim0.gif" {
                                        let gifName = selectedGifName.replacingOccurrences(of: ".gif", with: "")

                                        DispatchQueue.global(qos: .userInitiated).async {
                                            if let gifFrames = extractFramesFromGIF(named: gifName) {
                                                overlayGIFFramesOnScreenshots(gifFrames: gifFrames)
                                            }

                                            // Once processing is done, switch back to the main thread
                                            DispatchQueue.main.async {
                                                self.generateVideoWithAudio()
                                            }
                                        }
                                    } else {
                                        self.generateVideoWithAudio()
                                    }
                                }) {
                                    Text("Save video")
                                }
                                .disabled(isButtonActive)

                                
                                Button(action: {
                                    // Action for third item
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                                            let captureRect = CGRect(x: 0, y: (UIScreen.main.bounds.height - imageHeight - 40)/2, width: imageWidth, height: imageHeight + 55) // Define the area to capture
                                            UIGraphicsBeginImageContextWithOptions(captureRect.size, false, UIScreen.main.scale)
                                            if let context = UIGraphicsGetCurrentContext() {
                                                context.translateBy(x: -captureRect.origin.x, y: -captureRect.origin.y)
                                                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
                                                let image = UIGraphicsGetImageFromCurrentImageContext()
                                                UIGraphicsEndImageContext()
                                                
                                                if let capturedImage = image {
                                                    UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
                                                    toastText = "Inspiration has been saved in gallery."
                                                    showToast = true
                                                } else {
                                                    print("Failed to capture image.")
                                                }
                                            }
                                        }
                                    }
                                }) {
                                    Text("Save screenshot")
                                }
                                .disabled(isButtonActive)
                            } label: {
                                Image("save_icon")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(.gray)
                            }
                        } else {
                            Image("save_icon_disable")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            //                             Hide text action
                            text_enable.toggle()
//                            typewriterEffectEnabled = false
                        }) {
                            Image(!isButtonActive ? "text_icon" : "text_icon_disable")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.gray)
                        }
                        .disabled(isButtonActive)
                        
                        Button(action: {
                            // Hide painting action
                            image_enable.toggle()
                        }) {
                            Image(!isButtonActive ? "painting_icon" : "painting_icon_disable")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.gray)
                        }
                        .disabled(isButtonActive)
                        
                        Button(action: {
                            // Animation spinner action
                            effect_enable = true
                        }) {
                            Image(!isButtonActive ? "effect_icon" : "effect_icon_disable")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.gray)
                        }
                        .disabled(isButtonActive)
                    }
                    .padding(.bottom, 10)
                }
            }
            .zIndex(1)
        }
        .onAppear {
            showMenu = false
            if isButtonActive {
                let trackWebUrl = "https://open.spotify.com/track/\(musicUrl)"
                print("trackWebUrl: \(trackWebUrl)")
                fetchPreviewUrlFromMeta(trackWebUrl: trackWebUrl) { url in
                    DispatchQueue.main.async {
                        if let url = url {
                            if let previewUrl = URL(string: url) {
                                audioPlayer.playPreview(from: previewUrl, musicName: musicName) { isPlay in
                                    ScreenshotView_enable = isPlay
                                }
                            } else {
                                print("Failed to create URL from string")
                            }
                        } else {
                            ScreenshotView_enable = true
                            print("No valid preview URL found.")
                        }
                    }
                }
            }
        }
        .onDisappear {
            audioPlayer.stop()
            stopScreenCapturing()
        }
        .overlay(
            Group{
                VStack {
                    if effect_enable {
                        animEffectView(selectedGifName: $selectedGifName, effect_enable: $effect_enable)
                            .transition(.move(edge: .trailing))
                            .background(Color.black.opacity(0.5))
                    }
                }
            }
        )
        .overlay(
            CustomToastView(toastText: $toastText, showToast: $showToast)
                .animation(.easeInOut, value: showToast)
                .transition(.opacity)
        )
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)

    }

    func startScreenCapturing() {
        let processor = VideoProcessor()
            processor.clearStoredScreenshots()
            audioPlayer.seekToStart()
            isCapture = true
            frameIndex = 0
            startScreenshotTimer()
            let duration: Double = (Double(inspiration.count) * typewriterSpeed) > 30 ? (Double(inspiration.count) * typewriterSpeed + 6) : 30
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                self.stopScreenCapturing()
                isButtonActive = false
            }
        }
        
        func startScreenshotTimer() {
            let processor = VideoProcessor()
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                self.captureScreenshot { image in
                    if let image = image {
                        DispatchQueue.global(qos: .background).async {
                            _ = processor.storeScreenshotOnDisk(image: image, index: frameIndex)
                            DispatchQueue.main.async {
                                self.frameIndex += 1
                                print("frameIndex:\(frameIndex)")
                            }
                        }
                    }
                }
            }
        }
        
        func stopScreenCapturing() {
            isCapture = false
            timer?.invalidate()
            timer = nil
        }
        
        func captureScreenshot(completion: @escaping (UIImage?) -> Void) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                let captureRect = CGRect(x: 0, y: (UIScreen.main.bounds.height - imageHeight - 40)/2, width: imageWidth, height: imageHeight + 55)
                UIGraphicsBeginImageContextWithOptions(captureRect.size, false, UIScreen.main.scale)
                if let context = UIGraphicsGetCurrentContext() {
                    context.translateBy(x: -captureRect.origin.x, y: -captureRect.origin.y)
                    window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    completion(image)
                }
            }
        }
        
//        func extractFramesFromGIF(named gifName: String) -> [UIImage]? {
//            guard let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
//                  let gifData = try? Data(contentsOf: URL(fileURLWithPath: path)),
//                  let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
//                return nil
//            }
//    
//            var frames: [UIImage] = []
//            let count = CGImageSourceGetCount(source)
//    
//            for i in 0..<count {
//                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
//                    let image = UIImage(cgImage: cgImage)
//                    frames.append(image)
//                }
//            }
//    
//            return frames
//        }
//    
//        func overlayGIFFramesOnScreenshots(gifFrames: [UIImage]) {
//            let processor = VideoProcessor()
//            for index in 0..<frameIndex {
//                if let screenshot = processor.loadScreenshotFromDisk(index: index) {
//                    print("\(index)")
//                    let gifFrame = gifFrames[index % gifFrames.count]
//                    let renderer = UIGraphicsImageRenderer(size: screenshot.size)
//                    let overlayedImage = renderer.image { context in
//                        screenshot.draw(in: CGRect(origin: .zero, size: screenshot.size))
//                        gifFrame.draw(in: CGRect(origin: .zero, size: screenshot.size))
//                    }
//                    _ = processor.storeScreenshotOnDisk(image: overlayedImage, index: index)
//                }
//            }
//        }
    
    func extractFramesFromGIF(named gifName: String) -> [CGImage]? {
        guard let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
              let gifData = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            return nil
        }

        var frames: [CGImage] = []
        let count = CGImageSourceGetCount(source)

        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                frames.append(cgImage)
            }
        }

        return frames
    }

    func overlayGIFFramesOnScreenshots(gifFrames: [CGImage]) {
        let processor = VideoProcessor()
        for index in 0..<frameIndex {
            autoreleasepool {  // Ensure memory is freed after each iteration
                if let screenshot = processor.loadScreenshotFromDisk(index: index) {
                    print("\(index)")
                    
                    let gifFrame = gifFrames[index % gifFrames.count]
                    
                    let renderer = UIGraphicsImageRenderer(size: screenshot.size)
                    let overlayedImage = renderer.image { context in
                        screenshot.draw(in: CGRect(origin: .zero, size: screenshot.size))
                        if let cgContext = UIGraphicsGetCurrentContext() {
                            cgContext.saveGState() // Save current context state

                            // Flip the context vertically
                            cgContext.translateBy(x: 0, y: screenshot.size.height)
                            cgContext.scaleBy(x: 1.0, y: -1.0)

                            // Draw the GIF frame
                            cgContext.draw(gifFrame, in: CGRect(origin: .zero, size: screenshot.size))

                            cgContext.restoreGState() // Restore the context state
                        }
                    }
                    
                    _ = processor.storeScreenshotOnDisk(image: overlayedImage, index: index)
                }
            }
        }
    }

        
        func generateVideoWithAudio() {
            let processor = VideoProcessor()
            let size = CGSize(width: imageWidth, height: imageHeight + 100)
            let videoURL = processor.tempDir.appendingPathComponent("screenCapture.mp4")
            try? FileManager.default.removeItem(at: videoURL)
            
            let writer = try! AVAssetWriter(outputURL: videoURL, fileType: .mp4)
            let settings = [AVVideoCodecKey: AVVideoCodecType.h264, AVVideoWidthKey: size.width, AVVideoHeightKey: size.height] as [String: Any]
            let input = AVAssetWriterInput(mediaType: .video, outputSettings: settings)
            let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input, sourcePixelBufferAttributes: [
                kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB,
                kCVPixelBufferWidthKey as String: size.width,
                kCVPixelBufferHeightKey as String: size.height
            ])
            writer.add(input)
            writer.startWriting()
            writer.startSession(atSourceTime: .zero)
            
            var frameCount: Int64 = 0
            let bufferQueue = DispatchQueue(label: "videoBufferQueue")
            
            DispatchQueue.main.async {
                input.requestMediaDataWhenReady(on: bufferQueue) {
                    while input.isReadyForMoreMediaData && frameCount < self.frameIndex {
                        autoreleasepool {
                            if let image = processor.loadScreenshotFromDisk(index: Int(frameCount)),
                               let buffer = self.pixelBuffer(from: image, size: size) {
                                let time = CMTime(value: frameCount, timescale: 5)
                                adaptor.append(buffer, withPresentationTime: time)
                                frameCount += 1
                                print("frameCount: \(frameCount)")
                            }
                        }
                    }
                    if frameCount >= self.frameIndex {
                        input.markAsFinished()
                        writer.finishWriting {
                            self.addAudio(to: videoURL) { outputURL in
                                return
                            }
                        }
                    }
                }
            }
        }
        
        func pixelBuffer(from image: UIImage, size: CGSize) -> CVPixelBuffer? {
            var buffer: CVPixelBuffer?
            let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue!,
                         kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue!] as CFDictionary
            CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, attrs, &buffer)
            guard let pixelBuffer = buffer else { return nil }
            
            CVPixelBufferLockBaseAddress(pixelBuffer, [])
            let context = CGContext(data: CVPixelBufferGetBaseAddress(pixelBuffer),
                                    width: Int(size.width),
                                    height: Int(size.height),
                                    bitsPerComponent: 8,
                                    bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                    space: CGColorSpaceCreateDeviceRGB(),
                                    bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            if let cgImage = image.cgImage {
                context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
            }
            CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
            return pixelBuffer
        }
    
        func addAudio(to videoURL: URL, completion: @escaping (URL?) -> Void) {
            guard let audioURL = MyAudioPlayerManager.shared.currentAudioFileURL else {
                print("No audio file available")
                completion(nil)
                return
            }
    
            let mixComposition = AVMutableComposition()
    
            // Add video track
            let videoAsset = AVAsset(url: videoURL)
            guard let videoTrack = videoAsset.tracks(withMediaType: .video).first else {
                print("No video track found")
                completion(nil)
                return
            }
    
            guard let videoCompositionTrack = mixComposition.addMutableTrack(withMediaType: .video,
                                                                             preferredTrackID: kCMPersistentTrackID_Invalid) else {
                print("Failed to create video composition track")
                completion(nil)
                return
            }
    
            do {
                try videoCompositionTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration),
                                                          of: videoTrack,
                                                          at: .zero)
            } catch {
                print("Failed to insert video track: \(error.localizedDescription)")
                completion(nil)
                return
            }
    
            // Add audio track
            let audioAsset = AVAsset(url: audioURL)
            guard let audioTrack = audioAsset.tracks(withMediaType: .audio).first else {
                print("No audio track found")
                completion(nil)
                return
            }
    
            guard let audioCompositionTrack = mixComposition.addMutableTrack(withMediaType: .audio,
                                                                             preferredTrackID: kCMPersistentTrackID_Invalid) else {
                print("Failed to create audio composition track")
                completion(nil)
                return
            }
    
            let audioDuration = min(videoAsset.duration, audioAsset.duration)  // Trim audio if longer than video
            do {
                try audioCompositionTrack.insertTimeRange(CMTimeRange(start: .zero, duration: audioDuration),
                                                          of: audioTrack,
                                                          at: .zero)
            } catch {
                print("Failed to insert audio track: \(error.localizedDescription)")
                completion(nil)
                return
            }
    
            // Export combined video + audio
            let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("final_with_audio.mp4")
    
            if FileManager.default.fileExists(atPath: outputURL.path) {
                try? FileManager.default.removeItem(at: outputURL)
            }
    
            guard let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) else {
                print("Failed to create export session")
                completion(nil)
                return
            }
    
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mp4
            exportSession.exportAsynchronously {
                switch exportSession.status {
                case .completed:
                    if issave {
                        self.saveToPhotos(videoURL: outputURL)  // Optional: Save to Photos directly here
                        issave = false
                        toastText = "Video saved to gallery."
                        showToast = true
                    }
    //                if isshare {
    //                    let activityVC = UIActivityViewController(activityItems: [outputURL], applicationActivities: nil)
    //
    //                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
    //                       let rootVC = windowScene.windows.first?.rootViewController {
    //                        rootVC.present(activityVC, animated: true, completion: nil)
    //                    }
    //                    isshare = false
    //                }
                    if isshare {
                        DispatchQueue.main.async {
                            let activityVC = UIActivityViewController(activityItems: [outputURL], applicationActivities: nil)
    
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let rootVC = windowScene.windows.first?.rootViewController {
                                rootVC.present(activityVC, animated: true, completion: nil)
                            }
                            isshare = false
                        }
                    }
    
                    completion(outputURL)
                case .failed, .cancelled:
                    print("Export failed: \(exportSession.error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                default:
                    break
                }
            }
        }
    
    
        func saveToPhotos(videoURL: URL) {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    PHPhotoLibrary.shared().performChanges {
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
                    } completionHandler: { success, error in
                        if success {
                            print("Saved to Photos")
                        } else {
                            print("Save failed: \(error?.localizedDescription ?? "Unknown error")")
                        }
                    }
                }
            }
        }
    
    
//    func resizedImage(tpImage: UIImage, for size: CGSize) -> UIImage? {
//        let renderer = UIGraphicsImageRenderer(size: size)
//        return renderer.image { (context) in
//            tpImage.draw(in: CGRect(origin: .zero, size: size))
//        }
//    }
    
//    func captureScreenshot(completion: @escaping (UIImage?) -> Void) {
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
//            
//            let captureRect = CGRect(x: 0, y: (UIScreen.main.bounds.height - imageHeight - 40)/2, width: imageWidth, height: imageHeight + 55) // Define the area to capture
//            UIGraphicsBeginImageContextWithOptions(captureRect.size, false, UIScreen.main.scale)
//            if let context = UIGraphicsGetCurrentContext() {
//                context.translateBy(x: -captureRect.origin.x, y: -captureRect.origin.y)
//                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
////                let image = resizedImage(tpImage: UIGraphicsGetImageFromCurrentImageContext()!, for: CGSize(width: imageWidth * 0.75, height: (imageHeight  + 100) * 0.75))
//                let image = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                
//                if let capturedImage = image {
////                    UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
//                    completion(capturedImage)
//                } else {
//                    print("Failed to capture image.")
//                }
//            }
//        }
//    }
//    
////    func findScreenshotView(in view: UIView) -> UIView? {
////        for subview in view.subviews {
////            // Look for UIHostingController's rootView
////            if let hostingController = subview.next as? UIHostingController<ScreenshotView> {
////                return hostingController.view // Return the UIView containing ScreenshotView
////            } else if let found = findScreenshotView(in: subview) {
////                return found
////            }
////        }
////        return nil
////    }
//
//    //save screen capture section
//    func startScreenCapturing() {
//        screenshots.removeAll()
//        audioPlayer.seekToStart()
//        print("ScreenShot is started.")
//        isCapture = true
//        startScreenshotTimer()
//        let duration : Double = (Double(inspiration.count) * typewriterSpeed) > 30 ? (Double(inspiration.count) * typewriterSpeed + 6) : 30
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//            self.timer?.invalidate()
//            isButtonActive = false
//        }
//    }
//    
//    func startScreenshotTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
//                captureScreenshot { capturedImage in
//                    if let capturedImage = capturedImage {
//                        self.screenshots.append(capturedImage)
//                    }
//                }
//            
//        }
//    }
//    
//    func stopScreenCapturing() {
//        isCapture = false
//        timer?.invalidate() // Stop the timer
//        timer = nil
//        print("Screen capture stopped.")
//    }
//    
//    func overlayGIFFramesOnScreenshots(gifFrames: [UIImage]) -> [UIImage] {
//        var overlayedScreenshots: [UIImage] = []
//        
//        for (index, screenshot) in screenshots.enumerated() {
//            let gifFrame = gifFrames[index % gifFrames.count] // Loop through GIF frames
//            
//            let renderer = UIGraphicsImageRenderer(size: screenshot.size)
//            let overlayedImage = renderer.image { context in
//                screenshot.draw(in: CGRect(origin: .zero, size: screenshot.size)) // Draw original screenshot
//                gifFrame.draw(in: CGRect(origin: .zero, size: screenshot.size)) // Draw GIF frame at specified position
//            }
//            
//            overlayedScreenshots.append(overlayedImage)
//        }
//        
//        return overlayedScreenshots
//    }
//
//    func extractFramesFromGIF(named gifName: String) -> [UIImage]? {
//        guard let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
//              let gifData = try? Data(contentsOf: URL(fileURLWithPath: path)),
//              let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
//            return nil
//        }
//
//        var frames: [UIImage] = []
//        let count = CGImageSourceGetCount(source)
//
//        for i in 0..<count {
//            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
//                let image = UIImage(cgImage: cgImage)
//                frames.append(image)
//            }
//        }
//
//        return frames
//    }
//    
//    func generateVideoWithAudio() {
////        let size = CGSize(width: 720, height: 1080)
//        let size = screenshots.first?.size ?? CGSize(width: imageWidth, height: imageHeight + 100)
//        let videoURL = FileManager.default.temporaryDirectory.appendingPathComponent("screenCapture.mp4")
//        try? FileManager.default.removeItem(at: videoURL)
//        
//        let writer = try! AVAssetWriter(outputURL: videoURL, fileType: .mp4)
//        let settings = [
//            AVVideoCodecKey: AVVideoCodecType.h264,
//            AVVideoWidthKey: size.width,
//            AVVideoHeightKey: size.height
//        ] as [String: Any]
//        let input = AVAssetWriterInput(mediaType: .video, outputSettings: settings)
//        
//        //modify line
//        let adaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: input, sourcePixelBufferAttributes: [
//            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB,
//            kCVPixelBufferWidthKey as String: size.width,
//            kCVPixelBufferHeightKey as String: size.height
//        ])
//        writer.add(input)
//        writer.startWriting()
//        writer.startSession(atSourceTime: .zero)
//        
//        var frameCount: Int64 = 0
//        let bufferQueue = DispatchQueue(label: "videoBufferQueue")
//        input.requestMediaDataWhenReady(on: bufferQueue) {
//            while input.isReadyForMoreMediaData && frameCount < self.screenshots.count {
//                autoreleasepool {
//                    let image = self.screenshots[Int(frameCount)]
//                    if let buffer = self.pixelBuffer(from: image, size: size) {
//                        let time = CMTime(value: frameCount, timescale: 5)
//                        adaptor.append(buffer, withPresentationTime: time)
//                        frameCount += 1
//                        print(frameCount)
//                    }
//                }
//            }
//            if frameCount >= self.screenshots.count {
//                input.markAsFinished()
//                writer.finishWriting {
//                    self.addAudio(to: videoURL) { outputURL in
//                        return
//                    }
//                }
//            }
//        }
//    }
//    
//    func pixelBuffer(from image: UIImage, size: CGSize) -> CVPixelBuffer? {
//        var buffer: CVPixelBuffer?
//        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue!,
//                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue!] as CFDictionary
//        CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, attrs, &buffer)
//        guard let pixelBuffer = buffer else { return nil }
//        
//        CVPixelBufferLockBaseAddress(pixelBuffer, [])
//        let context = CGContext(data: CVPixelBufferGetBaseAddress(pixelBuffer),
//                                width: Int(size.width),
//                                height: Int(size.height),
//                                bitsPerComponent: 8,
//                                bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
//                                space: CGColorSpaceCreateDeviceRGB(),
//                                bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
//        if let cgImage = image.cgImage {
//            context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
//        }
//        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
//        return pixelBuffer
//    }
//    
//    func addAudio(to videoURL: URL, completion: @escaping (URL?) -> Void) {
//        guard let audioURL = MyAudioPlayerManager.shared.currentAudioFileURL else {
//            print("No audio file available")
//            completion(nil)
//            return
//        }
//        
//        let mixComposition = AVMutableComposition()
//
//        // Add video track
//        let videoAsset = AVAsset(url: videoURL)
//        guard let videoTrack = videoAsset.tracks(withMediaType: .video).first else {
//            print("No video track found")
//            completion(nil)
//            return
//        }
//
//        guard let videoCompositionTrack = mixComposition.addMutableTrack(withMediaType: .video,
//                                                                         preferredTrackID: kCMPersistentTrackID_Invalid) else {
//            print("Failed to create video composition track")
//            completion(nil)
//            return
//        }
//
//        do {
//            try videoCompositionTrack.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.duration),
//                                                      of: videoTrack,
//                                                      at: .zero)
//        } catch {
//            print("Failed to insert video track: \(error.localizedDescription)")
//            completion(nil)
//            return
//        }
//
//        // Add audio track
//        let audioAsset = AVAsset(url: audioURL)
//        guard let audioTrack = audioAsset.tracks(withMediaType: .audio).first else {
//            print("No audio track found")
//            completion(nil)
//            return
//        }
//
//        guard let audioCompositionTrack = mixComposition.addMutableTrack(withMediaType: .audio,
//                                                                         preferredTrackID: kCMPersistentTrackID_Invalid) else {
//            print("Failed to create audio composition track")
//            completion(nil)
//            return
//        }
//
//        let audioDuration = min(videoAsset.duration, audioAsset.duration)  // Trim audio if longer than video
//        do {
//            try audioCompositionTrack.insertTimeRange(CMTimeRange(start: .zero, duration: audioDuration),
//                                                      of: audioTrack,
//                                                      at: .zero)
//        } catch {
//            print("Failed to insert audio track: \(error.localizedDescription)")
//            completion(nil)
//            return
//        }
//
//        // Export combined video + audio
//        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("final_with_audio.mp4")
//
//        if FileManager.default.fileExists(atPath: outputURL.path) {
//            try? FileManager.default.removeItem(at: outputURL)
//        }
//
//        guard let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) else {
//            print("Failed to create export session")
//            completion(nil)
//            return
//        }
//
//        exportSession.outputURL = outputURL
//        exportSession.outputFileType = .mp4
//        exportSession.exportAsynchronously {
//            switch exportSession.status {
//            case .completed:
//                if issave {
//                    self.saveToPhotos(videoURL: outputURL)  // Optional: Save to Photos directly here
//                    issave = false
//                    toastText = "Video saved to gallery."
//                    showToast = true
//                }
////                if isshare {
////                    let activityVC = UIActivityViewController(activityItems: [outputURL], applicationActivities: nil)
////
////                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
////                       let rootVC = windowScene.windows.first?.rootViewController {
////                        rootVC.present(activityVC, animated: true, completion: nil)
////                    }
////                    isshare = false
////                }
//                if isshare {
//                    DispatchQueue.main.async {
//                        let activityVC = UIActivityViewController(activityItems: [outputURL], applicationActivities: nil)
//
//                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                           let rootVC = windowScene.windows.first?.rootViewController {
//                            rootVC.present(activityVC, animated: true, completion: nil)
//                        }
//                        isshare = false
//                    }
//                }
//
//                completion(outputURL)
//            case .failed, .cancelled:
//                print("Export failed: \(exportSession.error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//            default:
//                break
//            }
//        }
//    }
//
//    
//    func saveToPhotos(videoURL: URL) {
//        PHPhotoLibrary.requestAuthorization { status in
//            if status == .authorized {
//                PHPhotoLibrary.shared().performChanges {
//                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
//                } completionHandler: { success, error in
//                    if success {
//                        print("Saved to Photos")
//                    } else {
//                        print("Save failed: \(error?.localizedDescription ?? "Unknown error")")
//                    }
//                }
//            }
//        }
//    }
}

struct GIFfileView: UIViewRepresentable {
    let gifName: String					
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
           let gifData = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            webView.load(gifData, mimeType: "image/gif", characterEncodingName: "", baseURL: URL(fileURLWithPath: path))
        }
        webView.isUserInteractionEnabled = false // Prevent user interactions
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


struct VideoProcessor {
    let fileManager = FileManager.default
    let tempDir = FileManager.default.temporaryDirectory
    
    func storeScreenshotOnDisk(image: UIImage, index: Int) -> URL? {
        let fileURL = tempDir.appendingPathComponent("screenshot_\(index).jpg")
        if let data = image.jpegData(compressionQuality: 0.9) {
            try? data.write(to: fileURL)
            return fileURL
        }
        return nil
    }
    
    func loadScreenshotFromDisk(index: Int) -> UIImage? {
        let fileURL = tempDir.appendingPathComponent("screenshot_\(index).jpg")
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func clearStoredScreenshots() {
        do {
            let contents = try fileManager.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)
            for file in contents where file.lastPathComponent.hasPrefix("screenshot_") {
                try fileManager.removeItem(at: file)
            }
        } catch {
            print("Failed to clear stored screenshots: \(error)")
        }
    }
}
