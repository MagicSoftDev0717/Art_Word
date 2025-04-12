import SwiftUI

struct TypingEffectView: View {
    let fullText: String
    let show: Bool
    @State private var displayedText = ""
    
    @AppStorage("typewriterSpeed") private var typewriterSpeed = 0.2
    @AppStorage("fontSize") private var fontSize = 35

    var body: some View {
        RealPaperBackground {
            ScrollViewReader { proxy in
                ScrollView {
                    Text(displayedText)
                        .font(.system(.title, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .id("Bottom") // Identifier for scrolling
                }
                .onChange(of: displayedText) { _ in
                    // Ensure the scroll happens after content update
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo("Bottom", anchor: .bottom)
                        }
                    }
                }
                .onAppear {
                    startTyping()
                }
            }
        }
    }

    private func startTyping() {
        displayedText = ""
        var currentIndex = 0

        Timer.scheduledTimer(withTimeInterval: typewriterSpeed, repeats: true) { timer in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                displayedText.append(fullText[index])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

struct RealPaperBackground<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.white.opacity(0.9).ignoresSafeArea()

            VStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.clear)
                    .overlay(
                        content.padding()
                    )
                    .padding(.horizontal)
                    .padding(.top, 40)

                Spacer()
            }
        }
        .frame(height: 300)
    }
}
