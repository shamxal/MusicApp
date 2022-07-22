//
//  AlbumListViewModel.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

class AlbumListViewModel {
    var albumItems = [Albums]()
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    let shared = CoreDataHelper.shared
    
    func fetchLocalItems() {
        shared.fetch { [weak self] items in
            if !items.isEmpty {
                self?.albumItems = items
                self?.successCallback?()
            } else {
                getTop100Albums()
            }
        }
    }
    
    func getTop100Albums() {
        AlbumNetworkManager.shared.getTop100Albums { [weak self] items in
            self?.shared.add(albumItems: items)
            self?.fetchLocalItems()
        } failure: { [weak self] errorMessage in
            self?.errorCallback?(errorMessage)
        }
    }
}
