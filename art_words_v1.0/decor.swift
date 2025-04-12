//
//  decor.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI
import SideMenu

struct DecorView: View {
    @State private var isMenuOpen = false

    var body: some View {
        ZStack {
            // Main content view
            VStack {
                Text("This is the main content")
                    .padding()

                Button("Toggle Drawer") {
                    isMenuOpen.toggle()
                }
                .padding()
            }
            .disabled(isMenuOpen) // Disable interaction with the main view when the menu is open

            // Side menu overlay
            if isMenuOpen {
                SideMenuView(isMenuOpen: $isMenuOpen)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1) // Ensure it's above the main content
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut, value: isMenuOpen)
            }
        }
    }
}

struct SideMenuView: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isMenuOpen = false // Close the menu
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            Spacer()
            VStack {
                Text("Menu Item 1")
                    .padding()
                Text("Menu Item 2")
                    .padding()
                Text("Menu Item 3")
                    .padding()
            }
            .frame(width: 250)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.trailing)
            Spacer()
        }
        .background(Color.black.opacity(0.3))
        .onTapGesture {
            isMenuOpen = false // Close the menu when tapping outside
        }
    }
}

struct DecorView_Previews: PreviewProvider {
    static var previews: some View {
        DecorView()
    }
}
