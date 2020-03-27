//
//  EventDetailView.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class EventDetailView: UIView {
    
    public lazy var eventImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    public lazy var eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "event name"
        label.numberOfLines = 0
        label.font = UIFont(name: "Thonburi", size: 20)
        label.textColor = .black
        return label
    }()
    public lazy var eventDateLabel: UILabel = {
        let label = UILabel()
        label.text = "event date/s"
        label.font = UIFont(name: "Thonburi", size: 17)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    public lazy var eventLinkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Tickets", for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        button.tintColor = .white
        return button
    }()
    public lazy var eventPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "event price range"
        label.font = UIFont(name: "Thonburi", size: 17)
        label.textColor = .black
        return label
    }()
    public lazy var eventInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [eventNameLabel, eventPriceLabel, promoterLabel, pleaseNoteLabel])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var promoterLabel: UILabel = {
        let label = UILabel()
        label.text = "event price range"
        label.font = UIFont(name: "Thonburi", size: 17)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    public lazy var pleaseNoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "please note"
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Book", size: 17)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    public lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "venue name"
        label.font = UIFont(name: "Avenir Heavy", size: 17)
        label.textColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        return label
    }()
    public lazy var venueImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    public lazy var venueAddress: UILabel = {
        let label = UILabel()
        label.text = "venue addess"
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir Book", size: 12)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    public lazy var venueInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [venueNameLabel, venueAddress])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
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
        eventImageConstraints()
        ticketLinkConstraints()
        eventInfoConstraints()
        venueImageConstraints()
        venueInfoConstraints()
    }
    private func scrollViewContraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func contentViewContraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(300) //default is 1000, 250 makes it flexible
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint
        ])
    }
    private func eventImageConstraints() {
        contentView.addSubview(eventImage)
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4)
        ])
    }

    private func ticketLinkConstraints() {
        contentView.addSubview(eventLinkButton)
        eventLinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventLinkButton.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 10),
            eventLinkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            eventLinkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            eventLinkButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func eventInfoConstraints() {
        contentView.addSubview(eventInfoStack)
        eventInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventInfoStack.topAnchor.constraint(equalTo: eventLinkButton.bottomAnchor, constant: 8),
            eventInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            eventInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            eventInfoStack.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    private func venueImageConstraints() {
        contentView.addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueImage.topAnchor.constraint(equalTo: eventInfoStack.bottomAnchor, constant: 10),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueImage.widthAnchor.constraint(equalToConstant: 100),
            venueImage.heightAnchor.constraint(equalTo: venueImage.widthAnchor),
            venueImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    private func venueInfoConstraints() {
        contentView.addSubview(venueInfoStack)
        venueInfoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueInfoStack.topAnchor.constraint(equalTo: venueImage.topAnchor),
            venueInfoStack.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: 10),
            venueInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            venueInfoStack.heightAnchor.constraint(equalTo: venueImage.heightAnchor)
        ])
    }
}
