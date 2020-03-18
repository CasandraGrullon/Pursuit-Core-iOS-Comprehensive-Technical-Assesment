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
        return label
    }()
    public lazy var eventDateLabel: UILabel = {
        let label = UILabel()
        label.text = "event date/s"
        return label
    }()
    public lazy var eventLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "event link"
        return label
    }()
    public lazy var eventPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "event price range"
        return label
    }()
    public lazy var eventInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [eventNameLabel, eventDateLabel, eventLinkLabel, eventPriceLabel])
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
        return label
    }()
    public lazy var pleaseNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "please note"
        return label
    }()
    public lazy var eventDetailsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [promoterLabel, pleaseNoteLabel])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.backgroundColor = .white
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var venueNameLabel: UILabel = {
        let label = UILabel()
        label.text = "venue name"
        return label
    }()
    public lazy var venueImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    public lazy var venueAddress: UILabel = {
        let label = UILabel()
        label.text = "venue addess"
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
    //TODO: add mini map view
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
        eventInfoConstraints()
        eventDetailsConstraints()
        venueImageConstraints()
        venueInfoConstraints()
    }
    //add scrollview :,<
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
    private func eventImageConstraints() {
        contentView.addSubview(eventImage)
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventImage.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    private func eventInfoConstraints() {
        contentView.addSubview(eventInfoStack)
        eventInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventInfoStack.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 8),
            eventInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventInfoStack.heightAnchor.constraint(equalTo: eventImage.heightAnchor)
        ])
    }
    private func eventDetailsConstraints() {
        contentView.addSubview(eventDetailsStack)
        eventDetailsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventDetailsStack.topAnchor.constraint(equalTo: eventInfoStack.bottomAnchor, constant: 8),
            eventDetailsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventDetailsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventDetailsStack.heightAnchor.constraint(equalTo: eventInfoStack.heightAnchor)
        ])
    }
    private func venueImageConstraints() {
        contentView.addSubview(venueImage)
        venueImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueImage.topAnchor.constraint(equalTo: eventDetailsStack.bottomAnchor, constant: 10),
            venueImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            venueImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            venueImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    private func venueInfoConstraints() {
        contentView.addSubview(venueInfoStack)
        venueInfoStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            venueInfoStack.centerXAnchor.constraint(equalTo: venueImage.centerXAnchor),
            venueInfoStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            venueInfoStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            venueInfoStack.heightAnchor.constraint(equalTo: venueImage.heightAnchor)
        ])
    }
}
