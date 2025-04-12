//
//  aboutme_fragment.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import Core
import SwiftUI

struct AboutMePageData {
    let title: String
    let content: String
}

struct AboutMePagesView: View {
    @State private var selectedPage = 0 // State to track the current page in the pager
    
    let mypages: [AboutMePageData] = [
        AboutMePageData( title: "About Me", content: "I spent years of my life writing inspirational quotes that show the way I see the world and, whishing my writings to come alive and also aiming I could get closer to people with them, I decided to take them to digital platforms.\n\n➜"),
        AboutMePageData( title: "", content: "In order to encourage people to read them, I got in contact with an artist that creates oil paintings who permitted her art to join my writings with great enthusiasm. But I wanted to capture all the reader’s senses, so I also added music. Inspirations not only get displayed along with a piece of art, they also include a fragment of a beautiful piano melody thanks to Spotify.\n\n➜"),
        AboutMePageData( title: "", content: "Among my goals for Art&Words there is also a desire that it could serve as a platform for sharing/promoting art in the future.\n\nNamasté.\n-\nDiego Esteban"),
        ]
    
    let texts = [
        Text("Among my goals for Art")
            .font(.system(size: 23))
            .foregroundColor(Color.gray.opacity(0.7)),
//            .multilineTextAlignment(.center),
        Text("&")
            .font(.system(size: 23))
            .foregroundColor(Color.yellow.opacity(0.7)),
//            .multilineTextAlignment(.center),
        Text("Words there is also a desire that it could serve as a platform for sharing/promoting art in the future.\n\n")
            .font(.system(size: 23))
            .foregroundColor(Color.gray.opacity(0.7)),
//            .multilineTextAlignment(.center),
        Text("Namasté.")
            .font(.system(size: 23))
            .foregroundColor(Color.yellow.opacity(0.7)),
//            .multilineTextAlignment(.center),
        Text("\n-\nDiego Esteban")
            .font(.system(size: 23))
            .foregroundColor(Color.gray.opacity(0.7))
//            .multilineTextAlignment(.center)
    ]
    
    var body: some View {
        ZStack {
            
            // Background
            Image("background_help") // Replace with your drawable name
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            // ViewPager equivalent
            // Pager (TabView) to display pages
            TabView(selection: $selectedPage) {
//                ForEach(mypages.indices, id: \.self) { index in
                    
                    AboutMeView(mypageData: mypages[0])
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(radius: 20)
                            .padding(50)
                            .tag(0)
                
                    AboutMeView(mypageData: mypages[1])
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(radius: 20)
                            .padding(50)
                            .tag(1)
                
                    
                    VStack(spacing: 20) {

                                // Display the title
                            Text(mypages[2].title)
                                    .font(.system(size: 45, weight: .bold))
                                    .foregroundColor(Color.gray.opacity(0.63))
                                    .multilineTextAlignment(.center)

                                // Display the content in a scrollable text view
                                ScrollView {
                                    texts.reduce(Text(""), +)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding(40)
                            .background(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .shadow(radius: 20)
                            .padding(50)
                            .tag(1)
                    
//                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .padding(20)


        }
    }
}

struct AboutMePagesView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMePagesView()
    }
}
