//
//  SearchEventsController.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth

class SearchEventsController: UIViewController {
    
    private var searchMapView = EventsSearchMapView()
    private var searchTableView = SearchTableView()
    
    override func loadView() {
        view = searchTableView
        searchMapView.backgroundColor = .white
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
    private var isMapButtonPressed = false
    
    private var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchButton()
        configureTableView()
        getApiChoice()
        for event in events {
            updateButtonUI(event: event)
        }
        for art in artworks {
            updateButtonUI(art: art)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getApiChoice()
        configureSearchButton()
        configureTableView()
    }
    private func getApiChoice() {
        DatabaseService.shared.getUserApiChoice { [weak self] (result) in
            switch result{
            case .failure(let error):
                print(error)
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
        } else if userAPIChoice == "Rijksmuseum" {
            searchTableView.searchButton.backgroundColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            searchTableView.backgroundColor = .darkGray
            searchTableView.searchBarOne.placeholder = "Search by artist or keyword"
            searchTableView.searchBarOne.backgroundColor = .white
            
        } else {
            searchTableView.searchBarOne.backgroundColor = .red
        }
    }
    private func getEvents(keyword: String, postCode: String) {
        TicketMasterAPI.getEvents(keyword: keyword, postalCode: postCode) { [weak self] (result) in
            switch result {
            case .failure(let eventsError):
                print(eventsError)
            case .success(let events):
                if let noNil = events.embedded {
                    DispatchQueue.main.async {
                        self?.events = noNil.events
                    }
                    
                }
            }
        }
    }
    private func getArtCollection(keyword: String) {
        MuseumAPI.getCollections(search: keyword) { [weak self] (result) in
            switch result {
            case .failure(let artError):
                print(artError)
            case .success(let artworks):
                DispatchQueue.main.async {
                    self?.artworks = artworks.artObjects
                }
            }
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
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(changeView(_:)))
        } else {
            navigationItem.title = "Rijks Museum Collection"
            navigationItem.rightBarButtonItem?.accessibilityElementsHidden = true
            navigationItem.rightBarButtonItem?.isEnabled = false
            searchTableView.searchBarTwo.isHidden = true
        }
    }
    private func configureSearchButton() {
        searchTableView.searchButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside)
    }
    @objc private func changeView(_ sender: UIBarButtonItem){
        if isMapButtonPressed {
            view = searchMapView
        } else {
            view = searchTableView
        }
    }
    @objc private func searchButtonPressed(_ sender: UIButton) {
        if userAPIChoice == "Ticket Master" {
            guard let keyword = searchTableView.searchBarOne.text, !keyword.isEmpty,
                let zipcode = searchTableView.searchBarTwo.text, !zipcode.isEmpty else {
                    //add warning to fill all fields
                    print("missing fields")
                    return
            }
            getEvents(keyword: keyword, postCode: zipcode)
            searchTableView.searchBarOne.resignFirstResponder()
            searchTableView.searchBarTwo.resignFirstResponder()
        } else {
            guard let artSearch = searchTableView.searchBarOne.text, !artSearch.isEmpty else {
                print("missing fields")
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
                    print(error)
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
                    print(error)
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
                        print(error)
                    case .success:
                        print("added to favorites")
                        self?.isFavorite = false
                        self?.updateButtonUI(event: event)
                        searchCell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    }
                }
            } else {
                DatabaseService.shared.addEventToFavorites(event: event) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success:
                        print("added to favorites")
                        self?.isFavorite = true
                        self?.updateButtonUI(event: event)
                        searchCell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)

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
                        print(error)
                    case .success:
                        print("added to favorites")
                        self?.isFavorite = false
                        self?.updateButtonUI(art: artwork)
                        searchCell.favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
                    }
                }
            } else {
                DatabaseService.shared.addArtToFavorites(artObject: artwork) { [weak self] (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success:
                        print("added to favorites")
                        self?.isFavorite = false
                        self?.updateButtonUI(art: artwork)
                        searchCell.favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                    }
                }
            }
        }
        
        
    }
}
