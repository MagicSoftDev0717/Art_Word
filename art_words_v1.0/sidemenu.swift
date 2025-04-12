//
//  sidemenu.swift
//  art_words_v1.0
//
//  Created by My iMac on 23/1/2025.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers
import Foundation
import Service

struct DocumentPicker: UIViewControllerRepresentable {
    var onFilePicked: (String) -> Void // Callback to send file content

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType(filenameExtension: "aw")!]) // Only text files
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator // Set delegate to Coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    // Coordinator to handle file selection
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        // Called when a file is picked
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedFileURL = urls.first else { return }
            print("📂 Selected File: \(selectedFileURL.path)")

            // Read file content
            do {
                let fileContent = try String(contentsOf: selectedFileURL, encoding: .utf8)
                DispatchQueue.main.async {
                    self.parent.onFilePicked(fileContent) // Send content back to SwiftUI
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
        
        // Called when user cancels picker
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("User canceled file selection.")
        }
        

    }
}

struct MenuView: View {
    @State private var isShareSheetShowing = false
    @Binding var showMenu: Bool
    @State private var showPicker = false
    
    @State private var fileContent = ""
    
    @State public var inspirationID1: Int64 = 0
    @State public var imageID1: Int64 = 0
    @State public var musicID1: Int64 = 0
    @State public var inspirationID: Int64 = 0
    @State public var imageID: Int64 = 0
    @State public var musicID: Int64 = 0
    
    @Binding public var musicUrl: String
    @Binding public var musicName: String
    @Binding public var inspiration: String
    @Binding public var imageUrl: String
    @Binding public var imageHeight: CGFloat
    @Binding public var imageWidth: CGFloat
    
    @State private var navigateToDetail = false
    @State public var isCapture = false
    
    @State public var sendtoEmail: String = ""
    
    var body: some View {
        VStack{
            Spacer(minLength: 300)
            VStack(alignment: .leading) {
                
                HStack {
                    Button(action: {
                        withAnimation {
                            showMenu = false // Toggle the menu visibility
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(16)
                    }
                    Image("paintingbrush_icon")
                        .font(.headline)
                        .foregroundColor(.yellow)
                        .padding(16)
                }
                
                
                NavigationLink(destination: SettingsView()) {
                    HStack {
                        Image(systemName: "gearshape")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding(.trailing, 10)
                        Text( LanguageManager.shared.localizedString(forKey: "menu_settings") )
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
                
                
                Button(action: {
                    //                openSettings() // Call your function here
                    isShareSheetShowing = true
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding(.trailing, 10)
                        Text( LanguageManager.shared.localizedString(forKey: "share_app") )
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
                .sheet(isPresented: $isShareSheetShowing) {
                            // Customize the text or URL as needed; for example, a link to your app on the App Store.
                    ShareSheet(activityItems: ["Please have a beautiful day using this app! https://www.appstore.com/art&words"])
                        .onDisappear {
                            showMenu = false
                        }
                    }
                
                NavigationLink(destination: ReportProblemView(musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, sendtoEmail: $sendtoEmail)) {
                    HStack {
                        Image(systemName: "text.bubble")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding(.trailing, 10)
                        Text( LanguageManager.shared.localizedString(forKey: "contact_me") )
                            .foregroundColor(.black)
                    }

                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    sendtoEmail = "diegopefm@gmail.com"
                })
                
                NavigationLink(destination: DrawerWithPagerView()) {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding(.trailing, 10)
                        Text( LanguageManager.shared.localizedString(forKey: "how_to_use") )
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }

                Button(action: {
                    //                openSettings() // Call your function here
                    showPicker = true
                }) {
                    HStack {
                        Image(systemName: "cloud")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding(.trailing, 10)
                        Text( LanguageManager.shared.localizedString(forKey: "open_inspiration") )
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
                        
//                        if let Content = fileContent {
//                            NavigationLink(destination: PlayView(musicUrl: $musicUrl, inspiration: $inspiration, backImage: $backImage, imageHeight: $imageHeight, imageWidth: $imageWidth)) {
//                                Text("Go to PlayView")
//                                    .padding()
//                                    .background(Color.green)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(10)
//                            }
//                        }

                
                NavigationLink(destination: AboutUsView(musicUrl: $musicUrl, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, musicName: $musicName)) {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding(.trailing, 10)
                        Text( LanguageManager.shared.localizedString(forKey: "about_app") )
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }

                
                Spacer()
                
                // Version description
                VStack(alignment: .center) {
                    Text("Version: 2.0.518923")
                        .font(.footnote)
                        .foregroundColor(.black)
                    Text("Copyright ©2019 Art&Words")
                        .font(.footnote)
                        .foregroundColor(.black)
                    Text("All Rights Reserved.")
                        .font(.footnote)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
            }
            .frame(maxWidth: 270)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                        withAnimation {
                            showMenu = false // Close the menu when an item is tapped
                        }
                    }
            
            NavigationLink(destination: PlayView(musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, isCapture: $isCapture), isActive: $navigateToDetail) {
                EmptyView()
            }
            .hidden()
        }
        .frame(maxHeight: .infinity)
        .sheet(isPresented: $showPicker) {
            DocumentPicker { content in
                let decryptedText = CryptoManager.decrypt(content)
                
                (inspirationID1, imageID1, musicID1) = readAWFile(from: decryptedText!)!
                
                inspirationID = inspirationID1
                imageID = imageID1
                musicID = musicID1
                
                print("Inspiration: \(inspirationID)")
                print("Painting: \(imageID)")
                print("Track: \(musicID)")

                imageUrl = DB_Manager().getURLbyID(id: Int64(imageID)) ?? ""
                musicUrl = DB_Manager().getMusicURLbyID(id: Int64(musicID)) ?? ""
                inspiration = DB_Manager().getInspirationText(id: Int64(inspirationID), idLanguage: Int64(2)) ?? ""
                musicName = DB_Manager().getMusicNamebyID(id: Int64(musicID)) ?? ""
//                imageHeight: CGFloat
//                imageWidth: CGFloat
                
                showPicker = false // Close picker after selection
//                showMenu = false
                
                navigateToDetail = true
            }
            .onDisappear {
//                showMenu = false
            }
        }
    }
    
    func readAWFile(from fileContent: String) -> (Int64, Int64, Int64)? {
        do {
            
            // Split by commas and new lines
            let parameters = fileContent.replacingOccurrences(of: "ArtAndWords:", with: "").components(separatedBy: "@")
            
            // Ensure correct number of parameters
            guard parameters.count == 3 else {
                print("Invalid file format")
                return nil
            }

            // Extract values
            let inspirationID = Int64(parameters[0])
            let imageID = Int64(parameters[1])
            let musicID = Int64(parameters[2])
            
            return (inspirationID, imageID, musicID) as? (Int64, Int64, Int64)
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}


//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//            .previewDevice("iPhone 14 Pro")
//    }
//}
