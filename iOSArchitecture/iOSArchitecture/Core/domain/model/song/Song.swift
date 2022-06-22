//
//  Song.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Foundation

struct SongList: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let name: String
    let artist: String
    let previewUrl: String
    
    init(name: String, artist: String, previewUrl: String = "") {
        self.name = name
        self.artist = artist
        self.previewUrl = previewUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case previewUrl = "previewUrl"
    }
}

extension Song {
    static var highSchoolMusical: [Song] {
        return [
            Song(name: "Now Or Never - Original Version", artist: "High School Musical Cast"),
            Song(name: "Right Here, Right Now - Original Version", artist: "High School Musical Cast, Vanessa Hudgens, Zac Efron"),
            Song(name: "I Want It All - Original Version", artist: "High School Musical Cast, Ashley Tisdale, Lucas Gabreel"),
            Song(name: "Can I Have This Dance - Original Version", artist: "High School Musical Cast, Vanessa Hudgens, Zac Efron"),
            Song(name: "A Night to Remember - Original Version", artist: "High School Musical Cast"),
            Song(name: "Just Wanna Be With You - Original Version", artist: "High School Musical Cast, Vanessa Hudgens, Lucas Gabreel, Zac Efron, Olesya Rulin"),
            Song(name: "The Boys Are Back - Original Version", artist: "High School Musical Cast, Corbin Bleu, Zac Efron"),
            Song(name: "Walk Away - Original Version", artist: "High School Musical Cast, Vanessa Hudgens"),
            Song(name: "Scream - Original Version", artist: "High School Musical Cast, Zac Efron"),
            Song(name: "Senior Year Spring Musical - Original Version", artist: "High School Musical Cast, Vanessa Hudgens, Ashley Tisdale, Lucas Gabreel, Zac Efron, Olesya Rulin, Matt Prokop"),
            Song(name: "We're All In This Together (Graduation Mix)", artist: "High School Musical Cast"),
            Song(name: "High School Musical - Original Version", artist: "High School Musical Cast"),
            Song(name: "Just Getting Started", artist: "High School Musical Cast, Stan Carrizosa"),
        ]
    }
}
