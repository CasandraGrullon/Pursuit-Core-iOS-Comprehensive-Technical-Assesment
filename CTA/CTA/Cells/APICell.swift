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
    
    public func configureCell(api: String) {
        apiNameLabel.text = api
        
    }
    
}
