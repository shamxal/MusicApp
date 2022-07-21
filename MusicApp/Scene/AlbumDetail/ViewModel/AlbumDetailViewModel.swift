//
//  AlbumDetailViewModel.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

class AlbumDetailViewModel {    
    var album: Album?
    
    init() {}
    
    init(album: Album) {
        self.album = album
    }
}
