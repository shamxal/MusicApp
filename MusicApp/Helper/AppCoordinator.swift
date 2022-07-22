//
//  AppCoordinator.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 22.07.22.
//

import Foundation
import UIKit

class AppCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showAlbumDetail(album: Albums) {
        let controller = AlbumDetailController(viewModel: AlbumDetailViewModel(album: album))
        navigationController.show(controller, sender: nil)
    }
}
