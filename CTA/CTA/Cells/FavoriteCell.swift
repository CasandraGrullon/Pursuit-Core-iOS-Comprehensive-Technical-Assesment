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
    @IBOutlet weak var cellDetailLabel: UILabel!
        
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
    }
    
    public func configureCell(event: FavoriteEvent) {
        cellLabel.text = event.eventName
        cellDetailLabel.text = event.eventDate
        cellDetailLabel.textColor = .lightGray
        image.kf.setImage(with: URL(string: event.eventImageURL))
    }
    public func configureCell(art: FavoriteArtwork) {
        cellLabel.text = art.artTitle
        cellLabel.textColor = .white
        cellDetailLabel.text = art.artistName
        cellDetailLabel.textColor = .lightGray
        image.kf.setImage(with: URL(string: art.artImageURL))
    }
    
}
