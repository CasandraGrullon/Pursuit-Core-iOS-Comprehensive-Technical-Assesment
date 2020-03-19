//
//  SearchCell.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {

    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var eventOrArtNameLabel: UILabel!
    @IBOutlet weak var eventDateOrArtistNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    public func updateUI(apichoice: String) {
        if apichoice == "Ticket Master" {
            favoriteButton.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        } else {
            favoriteButton.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        }
    }
    
    public func configureCell(event: Events) {
        guard let image = event.images.first?.url else {
            return
        }
        objectImage.kf.setImage(with: URL(string: image))
        eventOrArtNameLabel.text = event.name
        eventDateOrArtistNameLabel.text = event.dates.start.localDate
    }
    public func configureCell(art: ArtObjects) {
        objectImage.kf.setImage(with: URL(string: art.webImage.url))
        eventOrArtNameLabel.text = art.title
        eventDateOrArtistNameLabel.text = art.artist
        eventOrArtNameLabel.textColor = .white
        eventDateOrArtistNameLabel.textColor = .lightGray
    }
}
