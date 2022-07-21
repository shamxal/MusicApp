//
//  AlbumListController.swift
//  MusicApp
//
//  Created by Shamkhal Guliyev on 21.07.22.
//

import UIKit

class AlbumListController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: "\(AlbumCell.self)")
        return collectionView
    }()
    
    let viewModel = AlbumListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModelSetup()
    }
    
    fileprivate func setupUI() {
        title = "Top 100 Albums"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        constraints.append(collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92))
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func viewModelSetup() {
        viewModel.getTop100Albums()
        viewModel.errorCallback = { message in
            //TODO: Show error alert
            print("error: \(message)")
        }
        viewModel.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2 - 8, height: collectionView.frame.width / 2 - 8)
    }
}
