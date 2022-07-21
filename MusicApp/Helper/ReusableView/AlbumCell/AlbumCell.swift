//
//  AlbumCell.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import UIKit

protocol AlbumCellProtocol {
    var image: String { get }
    var title: String { get }
    var subTitle: String { get }
}

class AlbumCell: UICollectionViewCell {
    lazy private var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI() {
        addSubview(coverImage)
        addSubview(coverView)
        addSubview(artistLabel)
        addSubview(musicTitleLabel)
        
        layer.cornerRadius = 20
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(coverImage.topAnchor.constraint(equalTo: topAnchor))
        constraints.append(coverImage.bottomAnchor.constraint(equalTo: bottomAnchor))
        constraints.append(coverImage.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraints.append(coverImage.trailingAnchor.constraint(equalTo: trailingAnchor))
        
        constraints.append(coverView.topAnchor.constraint(equalTo: coverImage.topAnchor))
        constraints.append(coverView.bottomAnchor.constraint(equalTo: coverImage.bottomAnchor))
        constraints.append(coverView.leadingAnchor.constraint(equalTo: coverImage.leadingAnchor))
        constraints.append(coverView.trailingAnchor.constraint(equalTo: coverImage.trailingAnchor))
        
        constraints.append(artistLabel.bottomAnchor.constraint(equalTo: coverView.bottomAnchor, constant: -8))
        constraints.append(artistLabel.centerXAnchor.constraint(equalTo: coverView.centerXAnchor))
        constraints.append(artistLabel.widthAnchor.constraint(equalTo: coverView.widthAnchor, multiplier: 0.90))
        
        constraints.append(musicTitleLabel.leadingAnchor.constraint(equalTo: artistLabel.leadingAnchor))
        constraints.append(musicTitleLabel.trailingAnchor.constraint(equalTo: artistLabel.trailingAnchor))
        constraints.append(musicTitleLabel.bottomAnchor.constraint(equalTo: artistLabel.topAnchor, constant: -8))
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(data: AlbumCellProtocol) {
        coverImage.loadURL(data.image)
        artistLabel.text = data.subTitle
        musicTitleLabel.text = data.title
    }
}
