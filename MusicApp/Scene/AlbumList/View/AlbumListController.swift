//
//  AlbumListController.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import UIKit

class AlbumListController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "\(AlbumCell.self)")
        return collectionView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let viewModel = AlbumListViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModelSetup()
    }
    
    fileprivate func setupUI() {
        title = "Top 100 Albums"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        view.addSubview(indicator)
        view.addSubview(collectionView)
                
        refreshControl.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        collectionView.refreshControl = refreshControl
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(collectionView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        constraints.append(collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92))
        
        constraints.append(indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        constraints.append(indicator.widthAnchor.constraint(equalToConstant: 50))
        constraints.append(indicator.heightAnchor.constraint(equalToConstant: 50))
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func viewModelSetup() {
        viewModel.fetchLocalItems()
        viewModel.errorCallback = { [weak self] message in
            DispatchQueue.main.async {
                self?.present(AlertViewHelper.showAlert(message: message), animated: true)
            }
        }
        viewModel.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.indicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
    
    @objc fileprivate func refresh() {
        refreshControl.beginRefreshing()
        viewModel.fetchLocalItems()
    }
}

extension AlbumListController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.albumItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AlbumCell.self)", for: indexPath) as! AlbumCell
        cell.configure(data: viewModel.albumItems[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showAlbumDetail(index: indexPath.item)        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2 - 8, height: collectionView.frame.width / 2 - 8)
    }
}
