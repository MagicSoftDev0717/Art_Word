//
//  header.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//
import SwiftUI

struct DrawerTitleView: View {
    @Binding var showMenu: Bool
    @Binding var isButtonActive : Bool
    @Binding var isbackhidden: Bool
    
    @Binding public var musicUrl: String
    @Binding public var inspiration: String
    @Binding public var imageUrl: String
    @Binding public var imageHeight: CGFloat
    @Binding public var imageWidth: CGFloat
    @Binding public var musicName: String
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                // Close Button Icon
                    Button(action: {
                            presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back_arrow") // Replace with your asset name
                            .resizable()
                        //                        .scaledToFit()
                            .frame(maxWidth: 20, maxHeight: 24) // Adjust size as needed
                            .padding(.leading, 20)
                        //                .frame(height: 60, alignment: .center) // Align vertically
                    }
                    .opacity(isbackhidden ? 0 : 1)
                
                //            Spacer()
                
                Image("ic_logo") // Replace with your asset name
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 35)
                    .accessibility(label: Text("Logo"))
                
                //            Spacer()
                
                // Background Icon
                Button(action: {
                    withAnimation {
                        showMenu.toggle()
                    }
                }) {
                    Image("menu_icon_white")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 20) // Adjust height as needed
                        .frame(alignment: .trailing)
                        .padding(.trailing, 20)
                }
                .disabled(isButtonActive)
                //            Image("menu_icon_white") // Replace with your asset name
                //                .resizable()
                //                .scaledToFit()
                //                .frame(height: 20) // Adjust height as needed
                //                .frame(alignment: .trailing)
                //                .padding(.trailing, 20)
            }
            .frame(maxHeight: 50)
            .background(Color(hex: "#5AAE9E"))
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .overlay(
            Group {
                if showMenu {
                    HStack{
                        Spacer()
                        
                        MenuView(showMenu: $showMenu, musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth)
                            .transition(.move(edge: .trailing))
                    }
                    .background(Color.black.opacity(0.5))
                }
            }
        )
    }
}

//struct DrawerTitleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrawerTitleView()
//            .previewLayout(.sizeThatFits)
//    }
//}
