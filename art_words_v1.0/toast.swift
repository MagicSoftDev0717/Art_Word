//
//  toast.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI

struct CustomToastView: View {
    @Binding public var toastText: String
    @Binding public var showToast: Bool // Control visibility

    var body: some View {
        if showToast {
            VStack{
                Spacer()
                HStack {
                    VStack {
                        Text(toastText)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .padding(.horizontal, 10)
                            .multilineTextAlignment(.center)
                    }
                    .padding(5)
                }
                .background(Color(hex: "#5AAE9E").opacity(0.8)) // Toast background color
                .cornerRadius(10)
                .padding(.bottom, 60) // Position at bottom
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        showToast = false // Hide after 2 sec
                    }
                }
            }
        }
    }
}


//struct CustomToastView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomToastView()
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
