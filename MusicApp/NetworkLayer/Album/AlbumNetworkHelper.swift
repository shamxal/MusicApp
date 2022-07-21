//
//  AlbumNetworkHelper.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

enum AlbumEndpoint: String {
    case top100 = "music/most-played/100/albums.json"
}

enum AlbumNetworkHelper {
    case top100
    
    var path: String {
        switch self {
        case .top100:
            return NetworkHelper.shared.requestUrl(url: AlbumEndpoint.top100.rawValue)
        }
    }
}
