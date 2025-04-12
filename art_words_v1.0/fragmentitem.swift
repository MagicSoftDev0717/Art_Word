import SwiftUI
import Service

struct TypewriterText: View {
    let text: String
    let show: Bool  // This controls whether to start or stop typing
    let Height: CGFloat

    @State private var displayedText = ""
    @State private var charIndex = 0
    @State private var isTyping = false  // Controls typing animation

    @AppStorage("typewriterSpeed") private var typewriterSpeed = 0.2
    @AppStorage("fontSize") private var fontSize = 35

    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack {
                        Spacer() // Push text towards the center initially
                        
                        HStack {
                            Spacer() // Center text horizontally
                            Text(displayedText)
                                .font(.custom("Gloria", size: CGFloat(fontSize)))
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.7), radius: 6, x: 2, y: 2)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .id("TextEnd")
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)

                        Spacer() // Ensures some space at the bottom
                    }
                    .frame(minHeight: geometry.size.height) // Ensure content fills screen
                }
                .onAppear {
                    if show {
                        startTyping(proxy: proxy, scrollHeight: geometry.size.height)
                    } else {
                        displayedText = text // Directly show full text
                    }
                }
                .onChange(of: show) { newValue in
                    if newValue {
                        startTyping(proxy: proxy, scrollHeight: geometry.size.height)
                    } else {
                        displayedText = text // Show static text when stopping
                    }
                }
            }
        }
        .frame(height: Height - 100) // Restricting overall height to a fixed value
    }

    // Typing Function**
    private func startTyping(proxy: ScrollViewProxy, scrollHeight: CGFloat) {
        guard !isTyping, charIndex < text.count else { return }
        isTyping = true
        displayedText = "" // Reset text
        charIndex = 0
        typeNextCharacter(proxy: proxy, scrollHeight: scrollHeight)
    }

    private func typeNextCharacter(proxy: ScrollViewProxy, scrollHeight: CGFloat) {
        guard isTyping, charIndex < text.count else {
            isTyping = false
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + typewriterSpeed) {
            displayedText.append(text[text.index(text.startIndex, offsetBy: charIndex)])
            charIndex += 1

            withAnimation {
                proxy.scrollTo("TextEnd", anchor: .bottom)
            }

            typeNextCharacter(proxy: proxy, scrollHeight: scrollHeight)
        }
    }
}
