//
//  AlbumListViewModel.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

class AlbumListViewModel {
    var albumItems = [Album]()
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    func getTop100Albums() {
        AlbumNetworkManager.shared.getTop100Albums { [weak self] items in
            self?.albumItems = items
            self?.successCallback?()
        } failure: { [weak self] errorMessage in
            self?.errorCallback?(errorMessage)
        }
    }
}
