//
//  DetailController.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Kingfisher
import SafariServices

class EventDetailController: UIViewController {
    
    private let eventsDetailView = EventDetailView()
    
    override func loadView() {
        view = eventsDetailView
        eventsDetailView.backgroundColor = .white
        
    }
    
    public var event: Events
    private var isFavorite = false {
        didSet {
            if isFavorite{
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            } else {
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
            }
        }
    }
    public lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTapURL(_:)))
        
        return gesture
    }()
    
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
        isInFavorite()
        eventsDetailView.eventLinkLabel.isUserInteractionEnabled = true
        eventsDetailView.eventInfoStack.isUserInteractionEnabled = true
        eventsDetailView.eventLinkLabel.addGestureRecognizer(tapGesture)
        
    }

    private func configureNavBar() {
        navigationItem.title = event.name
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonPressed(_:)))
    }
    @objc func didTapURL(_ sender: UITapGestureRecognizer) {
        print("did tap")
        guard let url = URL(string: event.url) else {
            return
        }
        let safariPage = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariPage, animated: true)
    }
    
    @objc private func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        if isFavorite {
            DatabaseService.shared.removeEventFromFavorites(event: event) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to remove event from favorites", message: error.localizedDescription)
                    }
                case .success:
                    UIViewController.getNotification(title: "Removed from favorites", body: "\(String(describing: self?.event.name)) was removed")
                    self?.isFavorite = false
                }
            }
        } else {
            DatabaseService.shared.addEventToFavorites(event: event) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to add event to favorites", message: error.localizedDescription)
                    }
                case .success:
                    UIViewController.getNotification(title: "Added to favorites", body: "\(String(describing: self?.event.name)) was added")
                    self?.isFavorite = true
                }
            }
        }
    }
    private func isInFavorite() {
        DatabaseService.shared.isEventInFavorites(event: event) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to get user favorite events", message: error.localizedDescription)
                }
            case .success(let successful):
                if successful {
                    self?.isFavorite = true
                } else {
                    self?.isFavorite = false
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
        eventsDetailView.eventPriceLabel.text = "Prices: $\(event.priceRanges.first?.min ?? 10.0)0 - $\(event.priceRanges.first?.max ?? 10.0)0"
        eventsDetailView.promoterLabel.text = "Sponsored by: " + (event.promoter.name)
        eventsDetailView.pleaseNoteLabel.text = event.pleaseNote ?? ""
        eventsDetailView.venueImage.kf.setImage(with: URL(string: venueImage))
        eventsDetailView.venueNameLabel.text = venue.name
        eventsDetailView.venueAddress.text = "\(venue.address.line1)\n\(venue.city),\(venue.country) \(venue.postalCode)"
    }
    
}
