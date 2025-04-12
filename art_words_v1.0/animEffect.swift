//
//  animEffect.swift
//  art_words_v1.0
//
//  Created by My iMac on 6/2/2025.
//

import SwiftUI
import WebKit

// Custom view to display a GIF using WKWebView
struct GIFView: UIViewRepresentable {
    let name: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        // Configure the web view so it doesn't scroll or show a background
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Look for the GIF file in the bundle.
        if let path = Bundle.main.path(forResource: name, ofType: "gif"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            // Load the data into the web view
            uiView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: URL(fileURLWithPath: path))
        }
    }
}

// Main view presenting the GIFs in a scrollable list
struct animEffectView: View {
    @Binding var selectedGifName: String
    @Binding var effect_enable: Bool
    // Assuming your asset names are "gif1", "gif2", ..., "gif22"
    let gifNames = (0...21).map { "anim\($0)" }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(gifNames, id: \.self) { name in
                    Button(action: {
                        //Action when the button is tapped for this GIF
                        selectedGifName = "\(name).gif" // Pass the selected name back to PlayView
                        effect_enable = false
                    }){
                        GIFView(name: name)
                            .frame(height: 250) // Adjust the height as needed
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(5)
                    }
                    .buttonStyle(PressableButtonStyle(pressedOpacity: 0.2))
                }
            }
            .padding()
        }
//        .navigationTitle("My GIFs")
    }
}

struct PressableButtonStyle: ButtonStyle {
    var pressedOpacity: Double = 0.2

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? pressedOpacity : 1.0)
    }
}

//struct animEffectView_Previews: PreviewProvider {
//    static var previews: some View {
//        animEffectView()
//    }
//}
