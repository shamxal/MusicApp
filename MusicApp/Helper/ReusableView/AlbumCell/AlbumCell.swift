//
//  AlbumCell.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    lazy var coverImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func layoutSubviews() {
        layer.cornerRadius = 12
    }
}
