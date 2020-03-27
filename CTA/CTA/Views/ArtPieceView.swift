//
//  ArtPieceView.swift
//  CTA
//
//  Created by casandra grullon on 3/23/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ArtPieceView: UIView {

    public lazy var image: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        imageConstraints()
    }
    private func imageConstraints() {
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            image.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}
