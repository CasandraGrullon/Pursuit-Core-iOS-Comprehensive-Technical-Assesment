//
//  SearchCell.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher
protocol FavoriteButtonDelegate: AnyObject {
    func didPressButtonEvent(_ searchCell: SearchCell, event: Events)
    func didPressButtonArtwork(_ searchCell: SearchCell, artwork: ArtObjects)
}

class SearchCell: UITableViewCell {

    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var eventOrArtNameLabel: UILabel!
    @IBOutlet weak var eventDateOrArtistNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: FavoriteButtonDelegate?
    
    public func updateUI(apichoice: String) {
        if apichoice == "Ticket Master" {
            favoriteButton.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        } else {
            favoriteButton.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        }
    }
    public var event: Events!
    public var artwork: ArtObjects!
    public var apichoice = "" 
    
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
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if apichoice == "Ticket Master"{
            delegate?.didPressButtonEvent(self, event: event!)
        } else {
            delegate?.didPressButtonArtwork(self, artwork: artwork!)
        }
    }
}
