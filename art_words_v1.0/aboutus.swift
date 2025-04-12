//
//  aboutus.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct AboutUsView: View {
    @Binding public var musicUrl: String
    @Binding public var inspiration: String
    @Binding public var imageUrl: String
    @Binding public var imageHeight: CGFloat
    @Binding public var imageWidth: CGFloat
    @Binding public var musicName: String
    
    @State public var sendtoEmail: String = ""
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                    VStack(alignment: .center, spacing: 20) {
                        
                        // Logo Section
//                        VStack {
                            // Replace with your custom logo
                            Image("logo_artandwords")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 90)
                                .foregroundColor(.black)
                        
                        // Version Text
                        Text("Version 1.0.0")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        
                        // Change Log Link
                        NavigationLink(destination: VersionHistoryView()) {
                            Text("(Version History)")
                                .font(.system(size: 17))
                                .foregroundColor(.blue)
                                .underline(true, color: .blue)
                        }
                        
                        // About Us Text
                        Text("Copyright ©2019,\nDiego Pérez.\nAll Rights Reserved.")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        // Review Text
                        Text("Art&words has beautiful\ninspirations for you.")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        

                        // Expiration Placeholder
                        Link(destination: URL(string: "https://www.diegoperezresume.com/")!) {
                            Text("Visit My HomePage")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(Color(hex: "#5AAE9E"))
                                .underline(true, color: Color(hex: "#5AAE9E"))
                        }

                        
                        // Spotify Section
                        HStack {
                            Image(systemName: "music.note")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color(hex: "#5AAE9E"))
                            Text("Music previews thanks to")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                            Link(destination: URL(string: "https://open.spotify.com/")!) {
                                Text("Spotify")
                                    .font(.system(size: 18))
                                    .foregroundColor(.blue)
                                    .underline(true, color: .blue)
                            }
                        }
                        
                        // Paintings Section
                        HStack {
                            Image("paintbrush")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            Text("Paintings thanks to")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                            NavigationLink(destination: ReportProblemView(musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, sendtoEmail: $sendtoEmail)) {
                                Text("Amvi")
                                    .font(.system(size: 18))
                                    .foregroundColor(.blue)
                                    .underline(true, color: .blue)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                sendtoEmail = "amvironi12375@gmail.com"
                            })
                        }
                        
                        // English Translations Section
                        HStack {
                            Image("translation")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                            Text("English Translations thanks to\nAnalis and Delfina Trabattoni")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                        }
                        
                        // About Me Section
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color(hex: "#5AAE9E"))
                            Text("About")
                                .font(.system(size: 18))
                                .foregroundColor(.black)
                            NavigationLink (destination: AboutMePagesView()) {
                                Text("The Author")
                                    .font(.system(size: 18))
                                    .foregroundColor(.blue)
                                    .underline(true, color: .blue)
                                    .foregroundColor(.black)
                            }
                        }
                        // Report Problem Button
                        NavigationLink(destination: ReportProblemView(musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, sendtoEmail: $sendtoEmail)) {
                            Text("REPORT A PROBLEM")
                                .frame(maxWidth: 200, minHeight: 44)
                                .background(Color(hex: "#5AAE9E"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            sendtoEmail = "diegopefm@gmail.com"
                        })
                        .padding(20)
                    }
                    .padding(20)
            }
        }
//        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

//struct AboutUsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutUsView()
//    }
//}
