//
//  howtouse_fragement.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//
import Core
import SwiftUI

struct HelpPageData {
    let pageNumber: String
    let title: String
    let content: String
}

struct DrawerWithPagerView: View {
    @State private var selectedPage = 0 // State to track the current page in the pager
    
    let pages: [HelpPageData] = [
        HelpPageData(pageNumber: "1", title: "Why Art&Words?", content: "Art&Words would like to give you daily inspirational quotes to disconnect from the daily routine for a moment and meditate.\n\nInspirations will go along with pieces of art and small fragments of piano melodies by contemporary pianists.\n\n➜"),
        HelpPageData(pageNumber: "2", title: "Read Your Inspiration", content: "Art&Words will push a new notification every time there is a new inspirational quote for you according to the interval configured -by default once a day-, and when displayed, just open it to be able to read your inspiration, enjoy a new painting and listen to a nice melody.\n\n➜"),
        HelpPageData(pageNumber: "3", title: "Make Your Inspiration Alive", content: "Make your inspiration alive by adding an animation on it -what can be done using the magic wand- what will make the set even more beautiful to be shared then with someone special for you.\n\n➜"),
        HelpPageData(pageNumber: "4", title: "Give It To Someone Special", content: "You can share your inspiration once you have read it, for this use the icon located at bottom menu left. You can choose between three options, with the first you share a just screenshot, the second allows you to generate a small video, and you can use the third to generate a file with an .aw extension which can then be then opened on any device with the app installed.\n\n➜"),
        HelpPageData(pageNumber: "", title: "Have a \nbeautiful day.", content: "")
    ]
    
    let texts1_title = [
        Text("Why Art")
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(Color.gray.opacity(0.63)),
        Text("&")
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(Color.yellow.opacity(0.63)),
        Text("Words?")
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(Color.gray.opacity(0.63))
    ]
    
    let texts1_content = [
        Text("Art")
            .font(.system(size: 23))
            .foregroundColor(Color.gray.opacity(0.7)),
        Text("&")
            .font(.system(size: 23))
            .foregroundColor(Color.yellow.opacity(0.7)),
        Text("Words would like to give you daily inspirational quotes to disconnect from the daily routine for a moment and meditate.\n\nInspirations will go along with pieces of art and small fragments of piano melodies by contemporary pianists.\n\n➜")
            .font(.system(size: 23))
            .foregroundColor(Color.gray.opacity(0.7))
    ]
    
    let texts2_content = [
        Text("Art")
            .font(.system(size: 23))
            .foregroundColor(Color.gray.opacity(0.7)),
        Text("&")
            .font(.system(size: 23))
            .foregroundColor(Color.yellow.opacity(0.7)),
        Text("Words will push a new notification every time there is a new inspirational quote for you according to the interval configured -by default once a day-, and when displayed, just open it to be able to read your inspiration, enjoy a new painting and listen to a nice melody.\n\n➜")
            .font(.system(size: 23))
            .foregroundColor(Color.gray.opacity(0.7))
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
                //                ForEach(pages.indices, id: \.self) { index in
                
                VStack(spacing: 20) {
                    // Display the page number
                    Text(pages[0].pageNumber)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(Color.gray.opacity(0.7))
                        .multilineTextAlignment(.center)
                    
                    texts1_title.reduce(Text(""), +)
                        .multilineTextAlignment(.center)
                    
                    // Display the content in a scrollable text view
                    ScrollView {
                        texts1_content.reduce(Text(""), +)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(radius: 20)
                .padding(50)
                .tag(0)
                
                VStack(spacing: 20) {
                    // Display the page number
                    Text(pages[1].pageNumber)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(Color.gray.opacity(0.7))
                        .multilineTextAlignment(.center)
                    
                    // Display the title

                    
                    // Display the content in a scrollable text view
                    ScrollView {
                        texts2_content.reduce(Text(""), +)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(radius: 20)
                .padding(50)
                .tag(1)
                
                HowToUseView(pageData: pages[2])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .shadow(radius: 20)
                    .padding(50)
                    .tag(2)
                
                HowToUseView(pageData: pages[3])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .shadow(radius: 20)
                    .padding(50)
                    .tag(3)
                
                ZStack() {
                    VStack{
                        Spacer()
                        Text(pages[4].title)
                            .font(.custom("Gloria", size: 65))
                            .foregroundColor(Color.yellow.opacity(0.63))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding(20)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(radius: 20)
                .padding(EdgeInsets(top: 50, leading: 15, bottom: 50, trailing: 15))
                .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .padding(20)
        }
    }

    
}



struct DrawerWithPagerView_Previews: PreviewProvider {
    static var previews: some View {
        DrawerWithPagerView()
    }
}
