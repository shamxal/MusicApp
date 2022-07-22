//
//  Albums+CoreDataProperties.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 22.07.22.
//
//

import Foundation
import CoreData


extension Albums: AlbumCellProtocol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Albums> {
        return NSFetchRequest<Albums>(entityName: "Albums")
    }

    @NSManaged public var id: String?
    @NSManaged public var artistName: String?
    @NSManaged public var name: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var kind: String?
    @NSManaged public var artistID: String?
    @NSManaged public var artistURL: String?
    @NSManaged public var artworkUrl100: String?
    @NSManaged public var contentAdvisoryRating: String?
    @NSManaged public var url: String?
    @NSManaged public var genres: [String]?
    
    var image: String {
        artworkUrl100 ?? ""
    }
    
    var title: String {
        name ?? ""
    }
    
    var subTitle: String {
        artistName ?? ""
    }

}

extension Albums : Identifiable {

}
