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
    private var isFavorite = false
    
    private var art: Artwork! {
        didSet {
            DispatchQueue.main.async {
                self.artUI()
                self.navigationItem.title = self.art?.title
            }
        }
    }
    
    init?(coder: NSCoder, artwork: ArtObjects) {
        self.artwork = artwork
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArtDetails(artId: artwork.objectNumber)
        configureNavBar()
    }
    private func getArtDetails(artId: String) {
        MuseumAPI.getArtworkDetails(objectNumber: artId) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
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
            artDetailView.otherTitles.text = "other titles: \(art?.titles.joined(separator: ", ") ?? "")"
            artDetailView.mediumLabel.text = art?.physicalMedium
            artDetailView.artSizeLabel.text = art?.subTitle
            artDetailView.objectTypeLabel.text = art?.objectTypes.joined(separator: ",")
               
            artDetailView.artistNameLabel.text = art?.principalMaker
           }
    @objc private func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        if isFavorite {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            DatabaseService.shared.removeArtFromFavorites(artwork: art) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("removed from favorites")
                    self?.isFavorite = false
                }
            }
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            DatabaseService.shared.addArtToFavorites(artwork: art) { [weak self] (result) in
                switch result {
                case .failure(let error):
                print(error)
            case .success:
                print("added from favorites")
                    self?.isFavorite = true
                }
            }
        }
    }


}
