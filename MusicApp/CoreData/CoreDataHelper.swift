//
//  CoreDataHelper.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 22.07.22.
//

import Foundation

class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    let context = AppDelegate().persistentContainer.viewContext
    
    var errorCallback: ((String)->())?
    
    func fetch(complete: ([Albums])->()) {
        do {
            let items = try context.fetch(Albums.fetchRequest())
            complete(items)
        } catch {
            errorCallback?(error.localizedDescription)
        }
    }
    
    func fetch() -> [Albums] {
        do {
            return try context.fetch(Albums.fetchRequest())
        } catch {
            errorCallback?(error.localizedDescription)
        }
        return []
    }
    
    func delete(complete: @escaping()->()) {
        DispatchQueue.main.async { [weak self] in
            let albums = self?.fetch()
            for album in albums ?? [] {
                self?.context.delete(album)
            }
            do {
                try self?.context.save()
                complete()
            } catch {
                self?.errorCallback?(error.localizedDescription)
            }
        }
    }
    
    func add(albumItems: [Album]) {
        delete { [weak self] in
            guard let self = self else { return }
            for item in albumItems {
                let album = Albums(context: self.context)
                album.artistID = item.artistID
                album.artistName = item.artistName
                album.artistURL = item.artistURL
                album.artworkUrl100 = item.artworkUrl100
                album.contentAdvisoryRating = item.contentAdvisoryRating
                for genre in item.genres ?? [] {
                    album.genres?.append(genre.name ?? "")
                }
                album.id = item.id
                album.kind = item.kind
                album.name = item.name
                album.releaseDate = item.releaseDate
                album.url = item.url
                
                do {
                    try self.context.save()
                } catch {
                    self.errorCallback?(error.localizedDescription)
                }
            }
        }
    }
}
