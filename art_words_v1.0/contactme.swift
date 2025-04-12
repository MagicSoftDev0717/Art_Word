import SwiftUI
import MessageUI

struct ReportProblemView: View {
    @State private var selectedSubject = "Drop me a line" // Default subject selection
    @State private var name = ""
    @State private var email = ""
    @State private var subject = ""
    @State private var message = ""
    
    @State private var showMenu = false
    @State private var isShowingMailView = false
    @State private var showMailErrorAlert = false
    
    @State private var isButtonActive = false
    @State public var isbackhidden = false

    @Binding public var musicUrl: String
    @Binding public var musicName: String
    @Binding public var inspiration: String
    @Binding public var imageUrl: String
    @Binding public var imageHeight: CGFloat
    @Binding public var imageWidth: CGFloat
    
    @Binding public var sendtoEmail: String
    
    
    var body: some View {
        ZStack {
//            VStack {
//                DrawerTitleView(showMenu: $showMenu, isButtonActive: $isButtonActive, isbackhidden: $isbackhidden, musicUrl: $musicUrl, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, musicName: $musicName)
//                if !showMenu {
//                    Spacer()
//                }
//            }
//            .zIndex(2)
            
            // Main form content in a scroll view
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text("Contact Diego Esteban Pérez")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray),
                            alignment: .bottom
                        )

                    // Spinner (Picker)
                    Picker("Subject", selection: $selectedSubject) {
                        Text("Drop me a line").tag("Drop me a line")
                        Text("Report a Problem").tag("Report a Problem")
                        Text("Request a Feature").tag("Request a Feature")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .foregroundColor(.gray)

                    // Name Input
                    ZStack(alignment: .leading) {
                        if name.isEmpty {
                            Text("Your Name")
                                .foregroundColor(.gray) // Custom placeholder color
                                .padding(.leading, 16)
                                .opacity(0.5)
                        }
                        TextField("", text: $name)
                            .padding()
                            .foregroundColor(.black) // Ensures user input is visible
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    
                    ZStack(alignment: .leading) {
                        if name.isEmpty {
                            Text("Your Email")
                                .foregroundColor(.gray) // Custom placeholder color
                                .padding(.leading, 16)
                                .opacity(0.5)
                        }
                        TextField("", text: $email)
                            .padding()
                            .foregroundColor(.black) // Ensures user input is visible
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )



                    // Hidden Subject Field (if needed)
                    if false { // Change to true if you want this field visible
                        TextField("Subject", text: $subject)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .foregroundColor(.gray)
                    }

                    // Message Input
                    ZStack(alignment: .topLeading) {
                        if message.isEmpty {
                            Text("Your Message")
                                .foregroundColor(.gray)
                                .opacity(0.5)
                                .padding(16)  // Adjust padding to match TextEditor
                                .zIndex(3)
                        }
                        TextEditor(text: $message)
                            .padding(8)
                            .background(Color.white)
                            .environment(\.colorScheme, .light)
                    }
                    .frame(minHeight: 100, maxHeight: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .foregroundColor(.gray)


                    // Send Button
                    HStack {
                        Spacer()
                        Button(action: {
                            // Check if device can send mail
                            if MFMailComposeViewController.canSendMail() {
                                isShowingMailView = true
                            } else {
                                showMailErrorAlert = true
                            }
                        }) {
                            Text("Send")
                                .fontWeight(.bold)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .sheet(isPresented: $isShowingMailView) {
                            // Customize the email fields as needed.
                            MailView(
                                recipients: ["\(sendtoEmail)"],
                                subject: selectedSubject, // or use a custom subject
                                messageBody: message
                            )
                        }
                        .alert(isPresented: $showMailErrorAlert) {
                            Alert(
                                title: Text("Mail services are not available"),
                                message: Text("Please configure your mail account in the Mail app."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
    }
    
    func sendEmail() {
        let url = URL(string: "https://your-cloud-function-url/sendEmail")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let emailData: [String: Any] = [
            "to": "amvironi12375@gmail.com",
            "subject": $selectedSubject,
            "message": $message
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: emailData, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error sending email: \(error)")
            } else {
                print("Email sent successfully!")
            }
        }.resume()
    }
}

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    var recipients: [String]
    var subject: String
    var messageBody: String

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView
        
        init(parent: MailView) {
            self.parent = parent
        }
        
        // Dismiss the mail composer when done
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            parent.presentation.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(recipients)
        vc.setSubject(subject)
        vc.setMessageBody(messageBody, isHTML: false)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

//struct ReportProblemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportProblemView()
//    }
//}
