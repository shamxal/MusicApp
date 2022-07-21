//
//  Album.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

struct FeedData: Codable {
    let feed: Feed?
}

// MARK: - Feed
struct Feed: Codable {
    let title: String?
    let id: String?
    let copyright, country: String?
    let icon: String?
    let updated: String?
    let results: [Album]?
}

// MARK: - Album
struct Album: Codable, AlbumCellProtocol {
    let artistName, id, name, releaseDate: String?
    let kind: String?
    let artistID: String?
    let artistURL: String?
    let contentAdvisoryRating: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?
    
    var image: String {
        artworkUrl100 ?? ""
    }
    
    var title: String {
        name ?? ""
    }
    
    var subTitle: String {
        artistName ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case contentAdvisoryRating, artworkUrl100, genres, url
    }
}

// MARK: - Genre
struct Genre: Codable {
    let genreID, name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}
