//
//  AlbumDetailController.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import UIKit

class AlbumDetailController: UIViewController {

    private lazy var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy private var artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var musicTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: "\(TitleCell.self)")
        return collectionView
    }()
    
    lazy private var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Released May 20, 2022\nCopyright 2022 Apple Inc. All rights reserved."
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var visitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Visit The Album", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        button.addTarget(self, action: #selector(visitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var viewModel = AlbumDetailViewModel()
    
    init(viewModel: AlbumDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        view.addSubview(coverImage)
        view.addSubview(artistLabel)
        view.addSubview(musicTitleLabel)
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
        view.addSubview(visitButton)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(coverImage.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(coverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(coverImage.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(coverImage.heightAnchor.constraint(equalTo: view.heightAnchor,
                                                             multiplier: 0.46))
        
        constraints.append(artistLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor,
                                                            constant: 16))
        constraints.append(artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(artistLabel.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                              multiplier: 0.92))
        
        constraints.append(musicTitleLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor,
                                                            constant: 16))
        constraints.append(musicTitleLabel.leadingAnchor.constraint(equalTo: artistLabel.leadingAnchor))
        constraints.append(musicTitleLabel.trailingAnchor.constraint(equalTo: artistLabel.trailingAnchor))
        
        constraints.append(collectionView.topAnchor.constraint(equalTo: musicTitleLabel.bottomAnchor,
                                                            constant: -12))
        constraints.append(collectionView.leadingAnchor.constraint(equalTo: musicTitleLabel.leadingAnchor))
        constraints.append(collectionView.trailingAnchor.constraint(equalTo: musicTitleLabel.trailingAnchor))
        constraints.append(collectionView.heightAnchor.constraint(equalToConstant: 60))
        
        constraints.append(visitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                               constant: -16))
        constraints.append(visitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(visitButton.widthAnchor.constraint(equalToConstant: 200))
        constraints.append(visitButton.heightAnchor.constraint(equalToConstant: 60))
        
        constraints.append(infoLabel.centerXAnchor.constraint(equalTo: visitButton.centerXAnchor))
        constraints.append(infoLabel.bottomAnchor.constraint(equalTo: visitButton.topAnchor,
                                                            constant: -32))
        constraints.append(infoLabel.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                              multiplier: 0.92))
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func configure() {
        artistLabel.text = viewModel.album?.artistName
        musicTitleLabel.text = viewModel.album?.name
        coverImage.loadURL(viewModel.album?.image ?? "")
    }
    
    @objc fileprivate func visitButtonTapped() {
        //TODO: open album url
        print("hello")
    }
}

extension AlbumDetailController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.album?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TitleCell.self)", for: indexPath) as! TitleCell
        cell.configure(title: viewModel.album?.genres?[indexPath.item].name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = viewModel.album?.genres?[indexPath.item].name?.count ?? 0
        let width = count*3 + 24
        return CGSize(width: width, height: 28)
    }
}
