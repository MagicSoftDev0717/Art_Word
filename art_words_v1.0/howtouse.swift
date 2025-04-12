//
//  howtouse.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct HowToUseView: View {
    var pageData: HelpPageData
    
    var body: some View {
        VStack(spacing: 20) {
                    // Display the page number
                    Text(pageData.pageNumber)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(Color.gray.opacity(0.7))
                        .multilineTextAlignment(.center)

                    // Display the title
                    Text(pageData.title)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color.gray.opacity(0.63))
                        .multilineTextAlignment(.center)

                    // Display the content in a scrollable text view
                    ScrollView {
                        Text(pageData.content)
                            .font(.system(size: 23))
                            .foregroundColor(Color.gray.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

//struct HowToUseView_Previews: PreviewProvider {
//    static var previews: some View {
//        HowToUseView()
//    }
//}
