//
//  DetailController.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher

class DetailController: UIViewController {

    private let eventsDetailView = EventDetailView()
    
    override func loadView() {
        view = eventsDetailView
        eventsDetailView.backgroundColor = .white
    }
    
    public var event: Events
    
    init?(coder: NSCoder, event: Events) {
        self.event = event
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        updateUI()

    }
    private func configureNavBar() {
        navigationItem.title = event.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonPressed(_:)))
    }
    @objc private func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    private func updateUI() {
        guard let eventImage = event.images.first?.url else {
            return
        }
        guard let venueImage = event.venueInfo.venues.first?.images.first?.url else {
            return
        }
        guard let venue = event.venueInfo.venues.first else {
            return
        }
        eventsDetailView.eventImage.kf.setImage(with: URL(string: eventImage))
        eventsDetailView.eventNameLabel.text = event.name
        eventsDetailView.eventDateLabel.text = "\(event.dates.start.localDate) at \(event.dates.start.localTime)"
        eventsDetailView.eventPriceLabel.text = "Prices: $\(event.priceRanges.first?.min ?? 10) - $\(event.priceRanges.first?.max ?? 20 )" //format
        eventsDetailView.promoterLabel.text = "Sponsored by: " + event.promoter.name
        eventsDetailView.pleaseNoteLabel.text = "Details\n\(event.pleaseNote ?? "")"
        eventsDetailView.venueImage.kf.setImage(with: URL(string: venueImage))
        eventsDetailView.venueNameLabel.text = venue.name
        eventsDetailView.venueAddress.text = "\(venue.address.line1)\n\(venue.city),\(venue.country) \(venue.postalCode)"
    }

}
