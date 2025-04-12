//
//  SpotifyAPI.swift
//  art_words_v1.0
//
//  Created by My iMac on 31/1/2025.
//

import Foundation
import AVFoundation

public class SpotifyAPI {
    static let clientID = "391a27fc849343d3914d6b04aa0fff41"
    static let clientSecret = "2be10c002b3f4e108c66db40294addfe"
    
    //  Fetch Spotify API Token
    public static func fetchSpotifyToken(completion: @escaping (String?) -> Void) {
        let credentials = "\(clientID):\(clientSecret)"
        let encodedCredentials = Data(credentials.utf8).base64EncodedString()
        
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(encodedCredentials)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to get token:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            completion(json?["access_token"] as? String)
        }.resume()
    }
    
    //  Fetch Spotify Track Preview URL
    public static func fetchSpotifyTrackPreview(trackID: String, token: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.spotify.com/v1/tracks/\(trackID)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Error fetching track:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            print("Spotify API Response:", String(data: data, encoding: .utf8) ?? "Invalid Response")
            
            completion(json?["preview_url"] as? String)
            
        }.resume()
    }
}

//  AVPlayer for Playing the Preview
public class SpotifyPlayer {
    static var player: AVPlayer?
    
    public static func playSpotifyPreview(url: String) {
        guard let trackURL = URL(string: url) else { return }
        player = AVPlayer(url: trackURL)
        player?.play()
    }
}
