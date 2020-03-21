//
//  FavoriteCell.swift
//  CTA
//
//  Created by casandra grullon on 3/20/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
        
    public func configureCell(event: FavoriteEvent) {
        cellLabel.text = event.eventName
        artistNameLabel.isHidden = true
        image.kf.setImage(with: URL(string: event.eventImageURL))
    }
    public func configureCell(art: FavoriteArtwork) {
        cellLabel.text = art.artTitle
        cellLabel.textColor = .white
        artistNameLabel.text = art.artistName
        artistNameLabel.textColor = .lightGray
        image.kf.setImage(with: URL(string: art.artImageURL))
    }
    
}
