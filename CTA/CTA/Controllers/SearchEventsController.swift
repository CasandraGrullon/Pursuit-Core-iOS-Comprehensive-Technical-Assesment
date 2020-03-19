//
//  SearchEventsController.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SearchEventsController: UIViewController {
    
    private var searchMapView = EventsSearchMapView()
    private var searchTableView = SearchTableView()
    
    override func loadView() {
        view = searchTableView
        searchMapView.backgroundColor = .white
    }
    
    private var events = [Events]() {
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.tableView.reloadData()
            }
        }
    }
    private var artworks = [ArtObjects]() {
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.tableView.reloadData()
            }
        }
    }
    private var isMapButtonPressed = false
    private var userAPIChoice = UserSession.shared.getAppUser()?.apiChoice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureSearchButton()
        configureTableView()
        updateUI()
    }
    private func updateUI() {
        searchTableView.tableView.backgroundColor = .clear
        if userAPIChoice == "Ticket Master" {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            searchTableView.searchButton.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            searchTableView.backgroundColor = .white
        } else {
            searchTableView.searchButton.backgroundColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            searchTableView.backgroundColor = .darkGray
            searchTableView.searchBarOne.placeholder = "Search by artist or keyword"
            searchTableView.searchBarOne.backgroundColor = .white
            
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
            cell.configureCell(event: event)
        } else {
            let artwork = artworks[indexPath.row]
            cell.configureCell(art: artwork)
        }
        cell.backgroundColor = .clear
        cell.updateUI(apichoice: userAPIChoice ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userAPIChoice == "Ticket Master" {
            let event = events[indexPath.row]
            let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
            let eventDetailVC = storyboard.instantiateViewController(identifier: "DetailController") { (coder) in
                return EventDetailController(coder: coder, event: event)
            }
            navigationController?.pushViewController(eventDetailVC, animated: true)
        } else {
            let artwork = artworks[indexPath.row]
            let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
            let artDetailVC = storyboard.instantiateViewController(identifier: "ArtDetailController") { (coder) in
                return ArtDetailController(coder: coder, artwork: artwork)
            }
            navigationController?.pushViewController(artDetailVC, animated: true)
        }
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
