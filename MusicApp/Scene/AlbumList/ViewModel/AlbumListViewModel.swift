//
//  AlbumListViewModel.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

class AlbumListViewModel {
    var coordinator: AppCoordinator?
    
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    var albumItems = [Albums]()
    let shared = CoreDataHelper.shared
    
    init() {}
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchLocalItems() {
        shared.fetch { [weak self] items in
            if !items.isEmpty {
                self?.albumItems = items
                self?.successCallback?()
                getTop100Albums()
            } else {
                getTop100Albums(shouldFetch: true)
            }
        }
    }
    
    func getTop100Albums(shouldFetch: Bool = false) {
        AlbumNetworkManager.shared.getTop100Albums { [weak self] items in
            self?.shared.add(albumItems: items)
            if shouldFetch {
                self?.fetchLocalItems()
            }
        } failure: { [weak self] errorMessage in
            self?.errorCallback?(errorMessage)
        }
    }
    
    func showAlbumDetail(index: Int) {
        coordinator?.showAlbumDetail(album: albumItems[index])
    }
}
