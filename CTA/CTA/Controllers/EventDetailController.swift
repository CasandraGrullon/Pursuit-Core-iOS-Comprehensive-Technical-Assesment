//
//  DetailController.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher

class EventDetailController: UIViewController {
    
    private let eventsDetailView = EventDetailView()
    
    override func loadView() {
        view = eventsDetailView
        eventsDetailView.backgroundColor = .white
        
    }
    
    public var event: Events
    private var isFavorite = false
    
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
        eventsUI()
    }
    private func configureNavBar() {
        
        navigationItem.title = event.name
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonPressed(_:)))
    }
    
    @objc private func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        if isFavorite {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            DatabaseService.shared.removeEventFromFavorites(event: event) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("removed from faves")
                    self?.isFavorite = false
                }
            }
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            DatabaseService.shared.addEventToFavorites(event: event) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success:
                    print("added to faves")
                    self?.isFavorite = true
                }
            }
        }
    }
    
    private func eventsUI() {
        
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
        eventsDetailView.promoterLabel.text = "Sponsored by: " + (event.promoter.name)
        eventsDetailView.pleaseNoteLabel.text = "Details\n\(event.pleaseNote ?? "")"
        eventsDetailView.venueImage.kf.setImage(with: URL(string: venueImage))
        eventsDetailView.venueNameLabel.text = venue.name
        eventsDetailView.venueAddress.text = "\(venue.address.line1)\n\(venue.city),\(venue.country) \(venue.postalCode)"
    }
    
}
