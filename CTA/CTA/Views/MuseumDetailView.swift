//
//  MuseumDetailView.swift
//  CTA
//
//  Created by casandra grullon on 3/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class MuseumDetailView: UIView {
    
    public lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.backgroundColor = .clear
        return scrollview
    }()
    public lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    public lazy var artImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    public lazy var artTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "artwork name"
        label.font = UIFont(name: "Thonburi", size: 30)
        label.textColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        return label
    }()
    public lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "artist name"
        label.textColor = .white
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.textColor = .white
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    public lazy var artDescription: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    public lazy var artInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [artTitleLabel, artistNameLabel, dateLabel, artDescription])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var otherTitles: UILabel = {
        let label = UILabel()
        label.text = "other titles"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    public lazy var mediumLabel: UILabel = {
        let label = UILabel()
        label.text = "medium used"
        label.textColor = .white
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    public lazy var objectTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "object type"
        label.textColor = .white
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    public lazy var artSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "size"
        label.textColor = .white
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    public lazy var artDetailsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [otherTitles, mediumLabel, objectTypeLabel, artSizeLabel])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var artistBirthDay: UILabel = {
        let label = UILabel()
        label.text = "birthday"
        label.font = UIFont(name: "Avenir", size: 17)
        return label
    }()

    public lazy var artistDeath: UILabel = {
        let label = UILabel()
        label.text = "day of death"
        label.font = UIFont(name: "Avenir", size: 17)
        return label
    }()

    public lazy var artistOccupation: UILabel = {
        let label = UILabel()
        label.text = "occpation"
        label.font = UIFont(name: "Avenir", size: 17)
        return label
    }()
    public lazy var artistInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [artistBirthDay, artistDeath, artistOccupation])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        scrollViewContraints()
        contentViewContraints()
        artworkImageConstraints()
        artInfoConstraints()
        artDetailsConstraints()
        //artistInfoConstraints()
    }

    private func scrollViewContraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let width = self.bounds.width
        let height = self.bounds.height
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: width),
            scrollView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func contentViewContraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    private func artworkImageConstraints() {
        contentView.addSubview(artImageView)
        artImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            artImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            artImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            artImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    private func artInfoConstraints() {
        contentView.addSubview(artInfoStack)
        artInfoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artInfoStack.topAnchor.constraint(equalTo: artImageView.bottomAnchor, constant: 20),
            artInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            artInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            artInfoStack.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    private func artDetailsConstraints() {
        contentView.addSubview(artDetailsStack)
        artDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artDetailsStack.topAnchor.constraint(equalTo: artInfoStack.bottomAnchor, constant: 10),
            artDetailsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            artDetailsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            artDetailsStack.heightAnchor.constraint(equalToConstant: 150),
            artDetailsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
//    private func artistInfoConstraints() {
//        contentView.addSubview(artistInfoStack)
//        artistInfoStack.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            artistInfoStack.topAnchor.constraint(equalTo: artDetailsStack.bottomAnchor, constant: 10),
//            artistInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            artistInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            artistInfoStack.heightAnchor.constraint(equalToConstant: 200),
//            artistInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
}
