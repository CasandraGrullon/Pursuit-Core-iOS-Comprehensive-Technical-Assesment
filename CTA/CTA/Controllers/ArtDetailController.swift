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
    
    private var art: Artwork! {
        didSet {
            DispatchQueue.main.async {
                self.artUI()
                self.configureNavBar()
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
        navigationItem.title = art?.title
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonPressed(_:)))
    }
    @objc private func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    private func artUI() {
        artDetailView.artistNameLabel.text = art?.title
        artDetailView.artDescription.text = art?.description
        artDetailView.artImageView.kf.setImage(with: URL(string: art?.webImage.url ?? ""))
        artDetailView.dateLabel.text = art?.dating.presentingDate
        artDetailView.otherTitles.text = "other titles: \(art?.titles.joined(separator: ",") ?? "")"
        artDetailView.mediumLabel.text = art?.physicalMedium
        artDetailView.artSizeLabel.text = art?.subTitle
        artDetailView.objectTypeLabel.text = art?.objectTypes.joined(separator: ",")
           
//        artDetailView.artistNameLabel.text = art?.principalMakers.first?.name
//        artDetailView.artistBirthDay.text = "born \(art?.principalMakers.dateOfBirth ?? "") in \(art?.principalMakers.placeOfBirth ?? "") "
//        artDetailView.artistDeath.text = "died \(art?.principalMakers.dateOfDeath ?? "") in \(art?.principalMakers.placeOfDeath ?? "")"
//        artDetailView.artistOccupation.text = "\(art?.principalMakers.occupation.joined(separator: "\n") ?? "")"
       }

}
