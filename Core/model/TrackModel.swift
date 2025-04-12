//
//  TrackModel.swift
//  Core
//
//  Created by My iMac on 24/1/2025.
//

import Foundation

class TrackModel: Identifiable {
    public var id: Int64 = 0
    public var idSpotify: String = ""
    public var name: String = ""
    public var album: String = ""
    public var author: String = ""
    public var spotifyPreviewUrl: String = ""
    public var musicType: Int64 = 0
}
