//
//  SearchEventsController.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth
import UserNotifications

class SearchEventsController: UIViewController {
    
    private var searchTableView = SearchTableView()
    
    override func loadView() {
        view = searchTableView
    }
    private var userAPIChoice = "" {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
                self.configureNavBar()
            }
        }
    }
    private var events = [Events]() {
        didSet {
            if userAPIChoice == "Ticket Master" {
                DispatchQueue.main.async {
                    self.searchTableView.tableView.reloadData()
                }
            }
        }
    }
    private var artworks = [ArtObjects]() {
        didSet {
            if userAPIChoice == "Rijksmuseum" {
                DispatchQueue.main.async {
                    self.searchTableView.tableView.reloadData()
                }
            }
            
        }
    }
    private var isFavorite = false {
        didSet {
            for event in events {
                updateButtonUI(event: event)
            }
            for art in artworks {
                updateButtonUI(art: art)
            }
        }
    }
    private let center = UNUserNotificationCenter.current()
    private let pendingNotifications = PendingNotifications()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiChoice()
        searchTableView.searchBarTwo.delegate = self
        searchTableView.searchBarOne.delegate = self
        configureSearchButton()
        configureTableView()
        checkForNotificationAuthorization()
        center.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getApiChoice()
    }
    private func checkForNotificationAuthorization() {
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                print("app is authorized for notifications")
            } else {
                self.requestNotificationPermission()
            }
        }
    }
    private func requestNotificationPermission() {
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("error requestion authorization: \(error)")
                return
            }
            if granted {
                print("access was granted")
            } else {
                print("access not granted")
            }
        }
    }
    private func getApiChoice() {
        DatabaseService.shared.getUserApiChoice { [weak self] (result) in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to get user experience", message: error.localizedDescription)
                }
            case .success(let api):
                self?.userAPIChoice = api
            }
        }
    }
    private func updateUI() {
        searchTableView.tableView.backgroundColor = .clear
        if userAPIChoice == "Ticket Master" {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            searchTableView.searchButton.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            searchTableView.backgroundColor = .white
            searchTableView.searchBarOne.isHidden = false
            searchTableView.searchBarTwo.isHidden = false
        } else {
            searchTableView.searchButton.backgroundColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            searchTableView.backgroundColor = .darkGray
            searchTableView.searchBarOne.placeholder = "Search by artist or keyword"
            searchTableView.searchBarOne.backgroundColor = .white
            searchTableView.searchBarTwo.isHidden = true
        }
    }
    private func configureTableView() {
        searchTableView.tableView.dataSource = self
        searchTableView.tableView.delegate = self
        searchTableView.tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "searchCell")
    }
    private func configureNavBar() {
        if userAPIChoice == "Ticket Master" {
            navigationItem.title = "Ticket Master Events"
        } else {
            navigationItem.title = "Rijks Museum Collection"
            navigationItem.rightBarButtonItem?.accessibilityElementsHidden = true
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    private func getEvents(keyword: String, postCode: String) {
        if userAPIChoice == "Ticket Master" {
            TicketMasterAPI.getEvents(keyword: keyword, postalCode: postCode) { [weak self] (result) in
                switch result {
                case .failure(let eventsError):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to get events from api", message: eventsError.localizedDescription)
                    }
                case .success(let events):
                    if let noNil = events.embedded {
                        DispatchQueue.main.async {
                            self?.events = noNil.events
                        }
                        
                    }
                }
            }
        }
        
    }
    private func getArtCollection(keyword: String) {
        if userAPIChoice == "Rijksmuseum" {
            MuseumAPI.getCollections(search: keyword) { [weak self] (result) in
                switch result {
                case .failure(let artError):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to get artwork from api", message: artError.localizedDescription)
                    }
                case .success(let artworks):
                    DispatchQueue.main.async {
                        self?.artworks = artworks.artObjects
                    }
                }
            }
        }
        
    }
    private func configureSearchButton() {
        searchTableView.searchButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside)
    }
    @objc private func searchButtonPressed(_ sender: UIButton) {
        if userAPIChoice == "Ticket Master" {
            guard let keyword = searchTableView.searchBarOne.text, !keyword.isEmpty,
                let zipcode = searchTableView.searchBarTwo.text, !zipcode.isEmpty else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Missing Fields", message: "please fill all required fields")
                    }
                    return
            }
            getEvents(keyword: keyword, postCode: zipcode)
            searchTableView.searchBarOne.resignFirstResponder()
            searchTableView.searchBarTwo.resignFirstResponder()
        } else {
            guard let artSearch = searchTableView.searchBarOne.text, !artSearch.isEmpty else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Missing Fields", message: "please fill all required fields")
                }
                return
            }
            getArtCollection(keyword: artSearch)
            searchTableView.searchBarOne.resignFirstResponder()
        }
    }
    private func updateButtonUI(art: ArtObjects? = nil, event: Events? = nil) {
        guard let event = event, let art = art else {
            return
        }
        if userAPIChoice == "Ticket Master" {
            DatabaseService.shared.isEventInFavorites(event: event) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to check user favorite events", message: error.localizedDescription)
                    }
                case .success(let successful):
                    if successful {
                        self?.isFavorite = true
                    } else {
                        self?.isFavorite = false
                    }
                }
            }
        } else {
            DatabaseService.shared.isArtInFavorites(artObject: art) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to check user favorite artworks", message: error.localizedDescription)
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
    }
    
}
extension SearchEventsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userAPIChoice == "Ticket Master" {
            return events.count
        } else {
            return artworks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not cast to search cell")
        }
        if userAPIChoice == "Ticket Master" {
            let event = events[indexPath.row]
            cell.event = event
            
            cell.configureCell(event: event)
        } else {
            let artwork = artworks[indexPath.row]
            cell.artwork = artwork
            cell.configureCell(art: artwork)
        }
        cell.backgroundColor = .clear
        cell.apichoice = userAPIChoice
        cell.updateUI(apichoice: userAPIChoice)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
        var detailVC = UIViewController()
        
        if userAPIChoice == "Ticket Master" {
            let event = events[indexPath.row]
            detailVC = storyboard.instantiateViewController(identifier: "DetailController") { (coder) in
                return EventDetailController(coder: coder, event: event)
            }
        } else {
            let artwork = artworks[indexPath.row]
            detailVC = storyboard.instantiateViewController(identifier: "ArtDetailController") { (coder) in
                return ArtDetailController(coder: coder, artwork: artwork)
            }
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension SearchEventsController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension SearchEventsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if userAPIChoice == "Ticket Master" {
            return 120
        } else {
            return 160
        }
    }
}
extension SearchEventsController: FavoriteButtonDelegate {
    func didPressButtonEvent(_ searchCell: SearchCell, event: Events) {
        if userAPIChoice == "Ticket Master"{
            if isFavorite {
                DatabaseService.shared.removeEventFromFavorites(event: event) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Unable to remove event from favorites", message: error.localizedDescription)
                        }
                    case .success:
                        UIViewController.getNotification(title: "Removed from favorites", body: "\(event.name) was removed")
                        self?.isFavorite = false
                        self?.updateButtonUI(event: event)
                        searchCell.favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
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
                        UIViewController.getNotification(title: "Added to favorites", body: "\(event.name) was added")
                        self?.isFavorite = true
                        self?.updateButtonUI(event: event)
                        searchCell.favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                        
                    }
                }
            }
            
        }
    }
    
    func didPressButtonArtwork(_ searchCell: SearchCell, artwork: ArtObjects) {
        if userAPIChoice == "Rijksmuseum" {
            if isFavorite {
                DatabaseService.shared.removeArtFromFavorites(artObject: artwork) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Unable to remove art from favorites", message: error.localizedDescription)
                        }
                    case .success:
                        UIViewController.getNotification(title: "Removed from favorites", body: "\(artwork.title) was removed")
                        self?.isFavorite = false
                        self?.updateButtonUI(art: artwork)
                        searchCell.favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                    }
                }
            } else {
                DatabaseService.shared.addArtToFavorites(artObject: artwork) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Unable to add art to favorites", message: error.localizedDescription)
                        }
                    case .success:
                        UIViewController.getNotification(title: "Added to favorites", body: "\(artwork.title) was added")
                        self?.isFavorite = true
                        self?.updateButtonUI(art: artwork)
                        searchCell.favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                    }
                }
            }
        }
        
        
    }
}
extension SearchEventsController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
