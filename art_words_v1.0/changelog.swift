//
//  changelog.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI
import WebKit

struct ChangeLogView: View {
    var body: some View {
        ZStack {
            // DrawerLayout equivalent
            VStack {
                // Main content
                WebViewWrapper(url: URL(string: "https://example.com/changelog")!) // Replace with the desired URL
                    .padding(10)
                    .background(Color.white)
            }
            
            // Drawer content placeholder
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Drawer Content") // Replace with your drawer content
                        .frame(width: 200, height: 50)
                        .background(Color.gray.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct WebViewWrapper: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct ChangeLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLogView()
    }
}
