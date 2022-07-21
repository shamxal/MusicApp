//
//  AlbumNetworkManager.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import Foundation

protocol AlbumNetworkProtocol {
    func getTop100Albums(compelete: @escaping([Album])->(), failure: @escaping(String)->())
}

class AlbumNetworkManager: AlbumNetworkProtocol {
    static let shared = AlbumNetworkManager()
    
    func getTop100Albums(compelete: @escaping ([Album]) -> (), failure: @escaping (String) -> ()) {
        NetworkManager.shared.makeRequest(type: FeedData.self,
                                          url: AlbumNetworkHelper.top100.path,
                                          method: .get) { response in
            switch response {
            case .failure(let error):
                failure(error.localizedDescription)
            case .success(let data):
                if let albums = data.feed?.results {
                    compelete(albums)
                }
            }
        }
    }
}
