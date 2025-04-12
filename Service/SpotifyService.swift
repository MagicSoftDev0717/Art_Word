//
//  SpotifyService.swift
//  art_words_v1.0
//
//  Created by TopDev on 10/2/2025.
//

import Foundation
internal import SwiftSoup
import AVFoundation



public func fetchPreviewUrlFromMeta(trackWebUrl: String, completion: @escaping (String?) -> Void) {
    guard let url = URL(string: trackWebUrl) else {
        completion(nil)
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data,
              error == nil,
              let html = String(data: data, encoding: .utf8) else {
            print("Error fetching HTML:", error?.localizedDescription ?? "Unknown error")
            completion(nil)
            return
        }
        
        do {
            let document = try SwiftSoup.parse(html)
            if let metaTag = try document.select("meta[property=og:audio]").first() {
                let previewUrl = try metaTag.attr("content")
                completion(previewUrl)
            } else {
                print("Meta tag not found")
                completion(nil)
            }
        } catch {
            print("HTML Parsing error:", error.localizedDescription)
            completion(nil)
        }
    }.resume()
}

public func playPreview(previewUrl: String) {
    var player: AVPlayer?
    
    guard let url = URL(string: previewUrl) else {
        print("Invalid preview URL")
        return
    }
    
    player = AVPlayer(url: url)
    player?.play()
}

//public class SpotifyPlayer {
//    static var player: AVPlayer?
//    
//    public static func playSpotifyPreview(url: String) {
//        guard let trackURL = URL(string: url) else { return }
//        player = AVPlayer(url: trackURL)
//        player?.play()
//    }
//}




public class AudioPlayerManager {
    public static let shared = AudioPlayerManager()
    var player: AVPlayer?

    /// Configures the audio session for background playback and plays the preview.
    public func playPreview(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        // Configure the audio session for background playback.
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Error setting up AVAudioSession:", error.localizedDescription)
        }
        
        // Initialize the AVPlayer with the preview URL and start playback.
        player = AVPlayer(url: url)
        player?.play()
    }
    
    public func stopPreview() {
        player?.pause()
        player?.seek(to: .zero) // Reset playback position (optional)
    }

}
