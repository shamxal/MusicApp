//
//  TitleCell.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 22.07.22.
//

import UIKit

class TitleCell: UICollectionViewCell {
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 14
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }
    
    func setupUI() {
        addSubview(titleLabel)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor))
        constraints.append(titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7))
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
