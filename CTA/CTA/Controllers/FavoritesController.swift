//
//  FavoritesController.swift
//  CTA
//
//  Created by casandra grullon on 3/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var userAPIChoice = "" {
        didSet {
            DispatchQueue.main.async {
                self.getFavorites(api: self.userAPIChoice)
            }
        }
    }
    private var refreshControl: UIRefreshControl!
    
    private var favoriteEvents = [FavoriteEvent]() {
        didSet {
            if userAPIChoice == "Ticket Master" {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    private var favoriteArtworks = [FavoriteArtwork]() {
        didSet {
            if userAPIChoice == "Rijksmuseum" {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        getApiChoice()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getApiChoice()
    }
    @objc private func loadData() {
        getApiChoice()
    }
    @objc private func getApiChoice() {
        DatabaseService.shared.getUserApiChoice { [weak self] (result) in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to get user app experience", message: error.localizedDescription)
                    self?.refreshControl.endRefreshing()
                }
            case .success(let api):
                self?.userAPIChoice = api
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    private func getFavorites(api: String) {
        if api == "Ticket Master" {
            DatabaseService.shared.getFavoriteEvents { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to get user favorite events", message: error.localizedDescription)
                        DispatchQueue.main.async {
                            self?.refreshControl.endRefreshing()
                        }
                    }
                case .success(let faveEvents):
                    DispatchQueue.main.async {
                        self?.favoriteEvents = faveEvents
                        self?.collectionView.backgroundColor = .white
                        self?.refreshControl.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
                        DispatchQueue.main.async {
                            self?.refreshControl.endRefreshing()
                        }
                    }
                }
            }
        } else {
            DatabaseService.shared.getFavoriteArtworks { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to get user favorite artworks", message: error.localizedDescription)
                        DispatchQueue.main.async {
                            self?.refreshControl.endRefreshing()
                        }
                    }
                case .success(let faveArtworks):
                    DispatchQueue.main.async {
                        self?.favoriteArtworks = faveArtworks
                        self?.collectionView.backgroundColor = .darkGray
                        self?.refreshControl.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
                        DispatchQueue.main.async {
                            self?.refreshControl.endRefreshing()
                        }
                    }
                }
            }
        }
    }
    private func actionSheet(event: FavoriteEvent? = nil, artwork: FavoriteArtwork? = nil) {
        let actionSheet = UIAlertController(title: "Edit Favorites", message: "", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Remove From Favorites", style: .destructive) { (action) in
            if let event = event, let artwork = artwork {
                DatabaseService.shared.editFavorites(event: event, artwork: artwork) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Unable to remove from favorites", message: error.localizedDescription)
                        }
                    case .success:
                        if self?.userAPIChoice == "Ticket Master" {
                            DispatchQueue.main.async {
                                self?.showAlert(title: "Removed from favorites", message: "\(event.eventName) was removed")
                            }
                        } else {
                            DispatchQueue.main.async {
                                self?.showAlert(title: "Removed from favorites", message: "\(artwork.artTitle) was removed")
                            }
                        }
                        
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
    }
    
}
extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth
        return CGSize(width: itemWidth, height: itemWidth * 0.90)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if userAPIChoice == "Ticket Master" {
            let event = favoriteEvents[indexPath.row]
            actionSheet(event: event)
        } else {
            let artwork = favoriteArtworks[indexPath.row]
            actionSheet(artwork: artwork)
        }
    }
    
}
extension FavoritesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userAPIChoice == "Ticket Master" {
            return favoriteEvents.count
        } else {
            return favoriteArtworks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError("could not cast to favoritecell")
        }
        if userAPIChoice == "Ticket Master" {
            let event = favoriteEvents[indexPath.row]
            cell.configureCell(event: event)
            cell.backgroundColor = .white
        } else {
            let artwork = favoriteArtworks[indexPath.row]
            cell.configureCell(art: artwork)
            cell.backgroundColor = .darkGray
        }
        return cell
    }
    
    
}

