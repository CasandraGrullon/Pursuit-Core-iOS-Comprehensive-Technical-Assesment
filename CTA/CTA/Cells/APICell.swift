//
//  APICell.swift
//  CTA
//
//  Created by casandra grullon on 3/18/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class APICell: UICollectionViewCell {
    @IBOutlet weak var apiImage: UIImageView!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var apiNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
    }
    
    public func configureCell(api: String) {
        apiNameLabel.text = api
        if api == "Rijksmuseum" {
            transparentView.backgroundColor = #colorLiteral(red: 0.2511523366, green: 0.5766504407, blue: 0.4910728335, alpha: 1)
            apiImage.image = #imageLiteral(resourceName: "museum")
        } else {
            transparentView.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            apiImage.image = #imageLiteral(resourceName: "ticketmaster")
        }
    }
    
}
