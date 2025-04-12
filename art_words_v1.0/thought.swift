//
//  thought.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct InspirationView: View {
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Video Layout
                VStack(spacing: 20) {
                    Text("Loading...")
                        .font(.title)
                        .foregroundColor(.black)
//                        .opacity(0) // Hidden by default
                    
                    // Painting Load Error
                    VStack(spacing: 10) {
                        Text("Error loading painting")
                            .font(.headline)
                            .foregroundColor(.black)
//                            .opacity(0) // Hidden by default
                        
                        HStack {
                            Text("Retry")
                                .font(.subheadline)
                                .foregroundColor(.black)
//                                .opacity(0) // Hidden by default
                            Text("Cancel")
                                .font(.subheadline)
                                .foregroundColor(.black)
//                                .opacity(0) // Hidden by default
                        }
                    }
                    
                    // Inspiration Layout
                    ZStack {
                        Image("image1") // Replace with actual image asset
                            .resizable()
                            .scaledToFit()
                        
                        Text("Your Inspiration Quote Here")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 6, x: 2, y: 2)
                            .multilineTextAlignment(.center)
                            .padding(30)
                    }
//                    .opacity(0) // Hidden by default
                    
                    // Signature Section
                    VStack(spacing: 10) {
                        HStack {
                            Text("Painting by:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.black)
                            Text("Artist Name")
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                        HStack {
                            Text("Thought by:")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.black)
                            Text("Author Name")
                                .font(.footnote)
                                .foregroundColor(.black)
                        }
                        Text("App © 2025 YourCompany")
                            .font(.footnote)
                            .foregroundColor(.black)
                    }
//                    .opacity(0) // Hidden by default
                }
                .padding(20)

                Spacer()

                // Bottom Menu
                HStack(spacing: 20) {
                    Button(action: {
                        // Share action
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Save action
                    }) {
                        Image(systemName: "tray.and.arrow.down")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Hide text action
                    }) {
                        Image(systemName: "textformat")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Hide painting action
                    }) {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: {
                        // Animation spinner action
                    }) {
                        Image(systemName: "sparkles")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            
            // Play/Pause Buttons
            HStack(spacing: 20) {
                Button(action: {
                    // Play action
                }) {
                    Image(systemName: "play.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    // Pause action
                }) {
                    Image(systemName: "pause.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
            }
//            .opacity(0) // Hidden by default
            .padding(.top, 20)
        }
    }
}

struct InspirationView_Previews: PreviewProvider {
    static var previews: some View {
        InspirationView()
    }
}
