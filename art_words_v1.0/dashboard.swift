//
//  main.swift
//  art_words_v1.0
//
//  Created by My iMac on 20/1/2025.
//

import SwiftUI
//import SQLite
import Service
//import Service
import SpotifyiOS

var backImages: [String: Image] = [:]

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        
        // Remove the "#" prefix if present
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        // Scan the hex value
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct DashboardView: View {
    @State public var imageHeight: CGFloat = 0 // Store the height dynamically
    @State public var imageWidth: CGFloat = 0
    @State private var showMenu = false
    @State private var idid: Int64 = 1
//    @State private var idLanguage: Int64 = 2
    @State public var inspirations: [String] = []
    @State public var inspiration: String = ""
    
    @State public var musicUrl: String = ""
    @State public var musicName: String = ""
    
    @State public var spotifyManager: SpotifyManager = SpotifyManager(musicUrl: "")
    
    @State private var imageUrls: [String] = []
    @State public var imageUrl: String = ""
    //    @State public var backImage: Image = Image("Background Image")
    
    @State private var ids: [Int64] = [1, 2, 3, 4, 5]
    @State private var firstLoad: Bool = true
    
    @State private var isimageload : Bool = false
    @State private var isButtonActive = false
    
    @State private var count : Int = 0
    @State public var isbackhidden: Bool = true
    @State public var isCapture: Bool = false
    
    @State private var imageName: String = ""
    @State private var savedImage: UIImage? = nil
    @State private var artlist: [String] = [""]
    
    @AppStorage("imageID") public var imageID = 0
    @AppStorage("musicID") public var musicID = 0
    @AppStorage("inspirationID") public var inspirationID = 0
    @AppStorage("lastDate") public var lastDate = "2025-01-01"
    @AppStorage("lastseenDate") public var lastseenDate = "2025-01-01"
    @AppStorage("idLanguage") public var idLanguage = 2
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                DrawerTitleView(showMenu: $showMenu, isButtonActive: $isButtonActive, isbackhidden: $isbackhidden, musicUrl: $musicUrl, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, musicName: $musicName)
                    .zIndex(2)
                    .offset(y: -0)
                
                // Inspiration Section
                VStack {
                    //                            Color.white.edgesIgnoringSafeArea(.all)
                    Spacer()
                    // Inspiration Image
                    
                    GeometryReader { geometry in
                        ScrollView {
                            VStack(spacing: 0) {
                                ZStack {
                                    VStack {
                                        NavigationLink(destination: PlayView(musicUrl: $musicUrl, musicName: $musicName, inspiration: $inspiration, imageUrl: $imageUrl, imageHeight: $imageHeight, imageWidth: $imageWidth, isCapture: $isCapture)) {
                                            //                                if firstLoad {
                                            // Save the image from network storage to local storage
                                            //                                    if let url = URL(string: imageUrl) {
                                            //                                        AsyncImage(url: url) { image in
                                            //                                            image
                                            //                                                .resizable()
                                            //                                                .scaledToFit()
                                            //                                                .frame(maxWidth: .infinity)
                                            //                                                .cornerRadius(10)
                                            //                                                .offset(y: -50)
                                            //                                                .background(
                                            //                                                    GeometryReader { geometry in
                                            //                                                        Color.clear
                                            //                                                        .onAppear {
                                            //                                                            imageHeight = geometry.size.height
                                            //                                                            imageWidth = geometry.size.width
                                            //                                                            isimageload = true
                                            //
                                            //                                                            downloadAndSaveImage(from: url)
                                            //                                                        }
                                            //                                                        .onChange(of: image) {_ in
                                            //                                                            imageHeight = geometry.size.height
                                            //                                                            imageWidth = geometry.size.width
                                            //                                                            isimageload = true
                                            //                                                        }
                                            //                                                    }
                                            //                                                )
                                            //
                                            //                                        } placeholder: {
                                            //                                            ProgressView() // Placeholder while the image loads
                                            //                                        }
                                            //                                    } else {
                                            //                                        Text("Image not available")
                                            //                                            .foregroundColor(.gray)
                                            //                                    }
                                            
                                            if let image = savedImage {
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(maxWidth: .infinity)
                                                    .cornerRadius(10)
                                                //                                        .offset(y: -50)
                                                //                                                    .padding(10)
                                                    .padding(.top, 60)
                                                    .padding(.leading, 20)
                                                    .padding(.trailing, 20)
                                                    .onAppear {
                                                        isimageload = true
                                                    }
                                                //                                            .padding(.bottom, 20)
//                                                                                                    .background(Color.black)
                                            }
//                                            else {
//                                                HStack{
//                                                    Spacer()
//                                                    Text("No image available")
//                                                        .foregroundColor(.gray)
//                                                    Spacer()
//                                                }
//                                            }
                                            
                                            
                                            //                                } else {
                                            //                                    backImage
                                            //                                        .resizable()
                                            //                                        .scaledToFit()
                                            //                                        .frame(maxWidth: .infinity)
                                            //                                        .cornerRadius(10)
                                            //                                        .offset(y: -50)
                                            //                                        .background(
                                            //                                            GeometryReader { geometry in
                                            //                                                Color.clear
                                            //                                                    .onAppear {
                                            //                                                        imageHeight = geometry.size.height
                                            //                                                        imageWidth = geometry.size.width
                                            //                                                    }
                                            //                                            }
                                            //                                        )
                                            //                                }
                                        }
                                    }
                                    .onAppear {
                                        imageHeight = geometry.size.height
                                        imageWidth = geometry.size.width
//                                        isimageload = true
                                        print("height\(imageHeight)")
                                    }
                                    .onChange(of: savedImage) { _ in
                                        imageHeight = geometry.size.height
                                        imageWidth = geometry.size.width
//                                        isimageload = true
                                    }
                                    
                                    if isimageload {
                                        HStack {
                                            VStack() {
                                                Text(inspiration) // Dynamically bind the inspiration value
                                                    .font(.system(size: 26, weight: .bold))
                                                    .foregroundColor(.white)
                                                    .shadow(color: Color.black.opacity(0.7), radius: 6, x: 2, y: 2)
                                                    .lineLimit(2)
                                                //                                        .lineLimit(nil) // Allows multi-line text
                                                    .frame(maxWidth: 200)
                                                    .multilineTextAlignment(.leading)
                                                //                                            .offset(y: -50) // Adjust position
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            //                                .padding(.bottom, 17)
                                            .padding(.leading, 50)
                                            
                                            Spacer()
                                            
                                            Image("next_icon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 40)
                                                .shadow(color: Color.black.opacity(0.7), radius: 6, x: 2, y: 2)
                                            //                                        .offset(y: -50)
                                                .padding(.trailing, 50)
                                        }
                                        .padding(.top, 50)
                                    }
                                }
                                //                            .frame(maxHeight: .infinity)
                                .onChange(of: imageHeight) { newValue in
                                    print("Image Height changed to: \(newValue)")
                                    //imageHeight = geometry.size.height // Reset image height or perform any other action when the URL changes
                                }
                                .onAppear {
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "yyyy-MM-dd"
                                    let today = formatter.string(from: Date())
                                    
                                    if today == lastDate {
                                        let lastData = readSavedData(selectedDate: lastseenDate)
                                        imageUrl = lastData?[0] ?? ""
                                        imageName = lastData?[1] ?? ""
                                        musicUrl = lastData?[2] ?? ""
                                        musicName = lastData?[3] ?? ""
                                        inspiration = lastData?[4] ?? ""
                                        musicName = DB_Manager().getMusicNamebyID(id: Int64(musicID)) ?? ""
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            savedImage = loadSavedImage(selectedDate: lastseenDate)
                                        }
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                            lastseenDate = today
//                                        }
                                    } else {
                                        imageID += 1
                                        if imageID > 105 {
                                            imageID = 1
                                        }
                                        musicID += 1
                                        if musicID > 124 {
                                            musicID = 1
                                        }
                                        inspirationID += 1
                                        if inspirationID > 339 {
                                            inspirationID = 1
                                        }
                                        imageUrl = DB_Manager().getURLbyID(id: Int64(imageID)) ?? ""
                                        musicUrl = DB_Manager().getMusicURLbyID(id: Int64(musicID)) ?? ""
                                        inspiration = DB_Manager().getInspirationText(id: Int64(inspirationID), idLanguage: Int64(idLanguage)) ?? ""
                                        musicName = DB_Manager().getMusicNamebyID(id: Int64(musicID)) ?? ""
                                        lastseenDate = today
//                                        DispatchQueue.global(qos: .background).async {
//                                            if let url = URL(string: imageUrl) {
//                                                downloadAndSaveImage(from: url)
//                                            }
//                                            saveNewData()
//                                            DispatchQueue.main.async {
//                                                readSavedData(selectedDate: today)
//                                                loadSavedImage(selectedDate: today)
//                                            }
//                                        }
                                        if let url = URL(string: imageUrl) {
                                            downloadAndSaveImage(from: url)
                                        }
                                        saveNewData()
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                            readSavedData(selectedDate: today)
                                            savedImage = loadSavedImage(selectedDate: today)
                                        }
                                        
                                        updateArtList()
                                        lastDate = today
                                    }
                                    
                                    artlist = readArtList()
                                    print("artlist: \(artlist)")
                                    
//                                    inspiration = DB_Manager().getInspirationText(id: 5, idLanguage: 2) ?? ""
//                                    imageUrls.removeAll()
//                                    for id in ids{
//                                        imageUrls.append(DB_Manager().getURLbyID(id: id) ?? "")
//                                    }
//                                    
//                                    musicUrl = DB_Manager().getMusicURLbyID(id: 5) ?? ""
//                                    musicName = DB_Manager().getMusicNamebyID(id: 5) ?? ""
//                                    
//                                    if let url = URL(string: imageUrl) {
//                                        downloadAndSaveImage(from: url)
//                                    }
//                                    saveNewdata()
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                        readSavedData()
//                                        loadSavedImage()
//                                    }
                                }
                                
                                // Inspiration Text
                                
                                
                                // Date Section
                                if isimageload {
                                    ZStack {
                                        VStack(spacing: 5) {
                                            Text( LanguageManager.shared.localizedString(forKey: "dashboard_todaysinspiration") )
                                                .font(.system(size: 20))
                                                .foregroundColor(Color.gray)
                                                .lineLimit(1)
                                            //                                        .opacity(0)
                                            
                                            Text(formattedDate(from: lastseenDate))
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.gray)
                                        }
                                        .frame(width: 170)
                                        .padding(15)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                    .offset(y: -40)
                                    //                                    .background(Color.black)
                                    //                        .padding(.top, 50)
                                    //                        .offset(y:imageHeight/2 - 90)
                                }
                                
                            }
                            .frame(minHeight: geometry.size.height)
                            //                    .padding(20)
                        }
//                        .background(Color.blue)
                        
                    }
                    //                    .background(Color.blue)
                    
                    Spacer()
                    
                    // Bottom Section: Quotes
                    //                VStack(alignment: .center) {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(artlist, id: \.self) { date in
                                Button(action: {
                                    //                                    firstLoad = false
                                    lastseenDate = date
                                    
                                    let lastData = readSavedData(selectedDate: lastseenDate)

//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        imageUrl = lastData?[0] ?? ""
                                        imageName = lastData?[1] ?? ""
                                        musicUrl = lastData?[2] ?? ""
                                        musicName = lastData?[3] ?? ""
                                        inspiration = lastData?[4] ?? ""
//                                    }
                                        savedImage = loadSavedImage(selectedDate: lastseenDate)
                                    
//                                    imageUrl = url
//                                    inspiration = inspirations[index]
//                                    
//                                    musicUrl = DB_Manager().getMusicURLbyID(id: Int64(index + 1)) ?? ""
//                                    musicName = DB_Manager().getMusicNamebyID(id: Int64(index + 1)) ?? ""
                                }) {
                                    QuoteCard(date: date)
                                }
                            }
                        }
                        .padding(5)
                    }
                    //                }
                    .frame(maxHeight: 140, alignment: .bottom)
                    .onAppear {
                        
                    }
                    //                    .background(Color.black)
                    
                }
            }
            .onAppear {
                // Make sure to close the menu when the settings view appears
                showMenu = false
                
                // Example: Fetch or update the inspiration value dynamically
                for id in ids{
                    inspirations.append(DB_Manager().getInspirationText(id: id, idLanguage: Int64(idLanguage)) ?? "")
                }
                
            }
            .navigationBarHidden(true)
        }
    }
    
//    var formattedDate: String {
//        let DataLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
//        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        formatter.locale = Locale(identifier: DataLanguage) // Use app’s selected language
//        return formatter.string(from: Date())
//    }
    
    func formattedDate(from customDate: String) -> String {
        let DataLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
        
        // Convert the custom date string to a Date object
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Match the format of your custom date string
        if let date = formatter.date(from: customDate) {
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: DataLanguage) // Use app’s selected language
            return formatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }

    
    func updateArtList() {
        let fileManager = FileManager.default
        
        // Get document directory path
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to get Documents directory")
            return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent("artlist.json")
        
        // Get today's date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        
        var dates: [String] = []
        
        // Check if file exists
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                dates = try JSONDecoder().decode([String].self, from: data)
            } catch {
                print("Failed to read or decode file: \(error.localizedDescription)")
            }
        }
        
        // Append today's date if it's not already in the list
        if !dates.contains(today) {
            dates.append(today)
            
            do {
                let updatedData = try JSONEncoder().encode(dates)
                try updatedData.write(to: fileURL, options: .atomic)
                print("Updated artlist.json with new date: \(today)")
            } catch {
                print("Failed to save updated file: \(error.localizedDescription)")
            }
        } else {
            print("Today's date already exists in artlist.json")
        }
    }

    func readArtList() -> [String] {
        let fileManager = FileManager.default

        // Get document directory path
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to get Documents directory")
            return []
        }

        let fileURL = documentsDirectory.appendingPathComponent("artlist.json")

        // Check if file exists
        guard fileManager.fileExists(atPath: fileURL.path) else {
            print("artlist.json does not exist")
            return []
        }

        do {
            let data = try Data(contentsOf: fileURL)
            var dates = try JSONDecoder().decode([String].self, from: data)
            
            // Sort dates in ascending order (oldest first)
            dates.sort()
            
            return dates
        } catch {
            print("Failed to read or decode file: \(error.localizedDescription)")
            return []
        }
    }

    
    private func downloadAndSaveImage(from url: URL) {
        let fileManager = FileManager.default

        // Get the Documents directory
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to get Documents directory")
            return
        }

        // Create "Images" directory inside Documents directory
        let imagesDirectory = documentsDirectory.appendingPathComponent("Images")

        // Check if the "Images" folder exists; if not, create it
        if !fileManager.fileExists(atPath: imagesDirectory.path) {
            do {
                try fileManager.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
                print("Images directory created at \(imagesDirectory.path)")
            } catch {
                print("Failed to create Images directory: \(error.localizedDescription)")
                return
            }
        }

        // Generate timestamp-based filename
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let timestamp = formatter.string(from: Date())

        // Save image as a JPG in the "Images" directory
        let fileURL = imagesDirectory.appendingPathComponent("\(timestamp).jpg")

        // Download image data asynchronously
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Failed to download or decode image")
                return
            }

            // Save the image data as a file
            do {
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    try imageData.write(to: fileURL)
                    print("Image saved successfully at \(fileURL.path)")
                }
            } catch {
                print("Failed to save image: \(error.localizedDescription)")
            }
        }

        task.resume()
    }


    
    public func loadSavedImage(selectedDate: String) -> UIImage? {
        let fileManager = FileManager.default

        // Get the Documents directory
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to get Documents directory")
            return nil
        }

        // Define the "Images" directory path
        let imagesDirectory = documentsDirectory.appendingPathComponent("Images")

        // Construct the file path for the selected date
        let fileURL = imagesDirectory.appendingPathComponent("\(selectedDate).jpg")

        // Check if the image file exists
        if fileManager.fileExists(atPath: fileURL.path) {
            if let image = UIImage(contentsOfFile: fileURL.path) {
                print("Image loaded successfully from \(fileURL.path)")
                return image // Return the loaded image
            } else {
                print("Failed to load image from file at \(fileURL.path)")
            }
        } else {
            print("Image file does not exist at \(fileURL.path)")
        }

        return nil // Return nil if the image couldn't be loaded
    }

    
    private func saveNewData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Example: 2025-03-09
        let timestamp = formatter.string(from: Date())

        let imageUrlValue = $imageUrl.wrappedValue
        let imageNameValue = "\(timestamp).jpg"
        let musicUrlValue = $musicUrl.wrappedValue
        let musicNameValue = $musicName.wrappedValue
        let inspirationValue = $inspiration.wrappedValue

        let text = "\(imageUrlValue)\n\(imageNameValue)\n\(musicUrlValue)\n\(musicNameValue)\n\(inspirationValue)"

        // Getting the URL of the Documents directory
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let historyDirectory = documentsDirectory.appendingPathComponent("history")

            // Check if "history" directory exists, if not, create it
            if !FileManager.default.fileExists(atPath: historyDirectory.path) {
                do {
                    try FileManager.default.createDirectory(at: historyDirectory, withIntermediateDirectories: true, attributes: nil)
                    print("Created 'history' directory at: \(historyDirectory.path)")
                } catch {
                    print("Failed to create 'history' directory: \(error)")
                    return
                }
            }

            // Creating the full URL for the new file inside "history" directory
            let fileURL = historyDirectory.appendingPathComponent("\(timestamp).json")

            do {
                // Writing the text to the file
                try text.write(to: fileURL, atomically: true, encoding: .utf8)
                print("Successfully saved new data to file at \(fileURL.path)")
            } catch {
                // Handle the error
                print("An error occurred while saving file: \(error)")
            }
        }
    }

    
    public func readSavedData(selectedDate: String) -> [String]? {
        // Get the Documents directory
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let historyDirectory = documentsDirectory.appendingPathComponent("history") // Append "history" directory
            let fileURL = historyDirectory.appendingPathComponent("\(selectedDate).json") // File path inside "history"
            
            do {
                // Read the file content as a string
                let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
                print("File content: \(fileContents)")
                
                // Process the contents and split into lines
                let lines = fileContents.split(separator: "\n").map { String($0) }
                
                // Return the lines array
                return lines
                
            } catch {
                // Handle the error if file doesn't exist or any other issue
                print("An error occurred while reading the file: \(error.localizedDescription)")
            }
        }
        
        // Return nil if reading fails
        return nil
    }



    
}

struct QuoteCard: SwiftUI.View {
    let date: String
    @State private var listImage: UIImage? = nil
    @State private var title: String = ""
    
    var body: some SwiftUI.View {
        ZStack {
            // Load the image from local stroage
            if let image = listImage {
                Image (uiImage: image)
                        .resizable()
                        .scaledToFit()
//                        .aspectRatio(contentMode: .fit)
                        .frame(height: 130)
                        .cornerRadius(10)
            }
//            else {
//                Text("Image not available")
//                    .foregroundColor(.gray)
//            }
            
            Text(title) // Dynamically bind the inspiration value
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.7), radius: 6, x: 2, y: 2)
                .lineLimit(2)
            //                                        .lineLimit(nil) // Allows multi-line text
                .frame(maxWidth: 40)
                .multilineTextAlignment(.leading)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let DashboardView = DashboardView()
                listImage = DashboardView.loadSavedImage(selectedDate: date)
                let datalist = DashboardView.readSavedData(selectedDate: date)
                title = datalist?[4] ?? ""
            }
        }
    }
}

//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some SwiftUI.View {
//        DashboardView()
//    }
//}
