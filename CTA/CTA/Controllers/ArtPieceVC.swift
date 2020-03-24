//
//  ArtPieceVC.swift
//  CTA
//
//  Created by casandra grullon on 3/23/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher

class ArtPieceVC: UIViewController {

    let artview = ArtPieceView()
    
    override func loadView() {
        view = artview
    }
    public var artwork: Artwork?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    private func updateUI() {
        guard let artImage = artwork?.webImage.url else {
            return
        }
        artview.image.kf.setImage(with: URL(string: artImage))
    }
    

}
