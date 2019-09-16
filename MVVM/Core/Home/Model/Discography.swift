//
//  Discography.swift
//  MVVM
//
//  Created by rodrigo camparo on 9/14/19.
//  Copyright © 2019 rodrigo camparo. All rights reserved.
//

import Foundation

struct Discography: Codable {
    let albums: [Album]
    let tracks: [Track]
    
    enum CodingKeys: String,CodingKey {
        case albums = "Albums"
        case tracks = "Tracks"
    }
}

struct Track: Codable {
    let id, name, trackArtWork, trackAlbum: String
    let artist: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case trackArtWork = "track_art_work"
        case trackAlbum = "track_album"
        case artist
    }
}

struct Album: Codable {
    
    let id, name, albumArtWork, artist: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case albumArtWork = "album_art_work"
        case artist
    }
}



// MARK: Convenience initializers

extension Album {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Album.self, from: data) else { return nil }
        self = me
    }
}
