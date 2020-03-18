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
    }
}
