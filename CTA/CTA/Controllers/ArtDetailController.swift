//
//  ArtDetailController.swift
//  CTA
//
//  Created by casandra grullon on 3/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher

class ArtDetailController: UIViewController {
    private var artDetailView = MuseumDetailView()
    
    override func loadView() {
        view = artDetailView
        artDetailView.backgroundColor = .darkGray
    }
    
    private var artwork: ArtObjects
    private var isFavorite = false {
        didSet {
            if isFavorite {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            } else {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            }
        }
    }
    
    private var art: Artwork? {
        didSet {
            DispatchQueue.main.async {
                self.artUI()
                self.navigationItem.title = self.art?.title
            }
        }
    }
    private lazy var tapGesture: UITapGestureRecognizer = {
       let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didPressImage(_:)))
        return gesture
    }()
    
    init?(coder: NSCoder, artwork: ArtObjects) {
        self.artwork = artwork
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isInFavorite()
        configureNavBar()
        getArtDetails(artId: artwork.objectNumber)
        artDetailView.artImageView.isUserInteractionEnabled = true
        artDetailView.contentView.isUserInteractionEnabled = true
        artDetailView.artImageView.addGestureRecognizer(tapGesture)
        
    }
    @objc private func didPressImage(_ sender: UITapGestureRecognizer) {
        let artworkDetail = ArtPieceVC()
        artworkDetail.artwork = art
        present(artworkDetail, animated: true)
    }
    private func getArtDetails(artId: String) {
        MuseumAPI.getArtworkDetails(objectNumber: artId) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to get art details from api", message: error.localizedDescription)
                }
            case .success(let artwork):
                self?.art = artwork.artObject
            }
        }
    }
    private func configureNavBar() {
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonPressed(_:)))
    }
    private func artUI() {
        artDetailView.artTitleLabel.text = art?.title
        artDetailView.artDescription.text = art?.plaqueDescriptionEnglish
        artDetailView.artImageView.kf.setImage(with: URL(string: art?.webImage.url ?? ""))
        artDetailView.dateLabel.text = art?.dating.presentingDate
        artDetailView.mediumLabel.text = art?.physicalMedium
        artDetailView.artSizeLabel.text = art?.subTitle
        artDetailView.objectTypeLabel.text = art?.objectTypes.joined(separator: ",")
        artDetailView.artistNameLabel.text = art?.principalMaker
    }
    private func isInFavorite() {
        guard let art = art else {
            return
        }
        DatabaseService.shared.isInFavorites(artwork: art) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to check user favorites", message: error.localizedDescription)
                }
            case .success(let successful):
                if successful {
                    self?.isFavorite = true
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Already in your favorites", message: "")
                    }
                } else {
                    self?.isFavorite = false
                }
            }
        }
    }
    @objc private func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        if isFavorite {
            DatabaseService.shared.removeFromFavorites(artwork: art) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to remove art from user favorites", message: error.localizedDescription)
                    }
                case .success:
                    UIViewController.getNotification(title: "Removed from favorites", body: "\(String(describing: self?.artwork.title)) was removed")
                    self?.isFavorite = false
                }
            }
        } else {
            DatabaseService.shared.addToFavorites(artwork: art) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to add art to user favorites", message: error.localizedDescription)
                    }
                case .success:
                    UIViewController.getNotification(title: "Added to favorites", body: "\(String(describing: self?.artwork.title)) was added")
                    self?.isFavorite = true
                }
            }
        }
    }
    
    
}
