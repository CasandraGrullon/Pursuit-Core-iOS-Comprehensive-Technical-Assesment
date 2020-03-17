//
//  SearchEventsController.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

enum UserAPIChoice {
    case ticketMaster
    case rijksMuseum
}

class SearchEventsController: UIViewController {

    private var searchMapView = EventsSearchMapView()
    private var searchTableView = SearchTableView()
    
    override func loadView() {
        view = searchTableView
        searchTableView.backgroundColor = .white
        searchMapView.backgroundColor = .white
    }
    //MARK: TicketMaster
    private var events = [Events]() {
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.tableView.reloadData()
            }
        }
    }
    private var isMapButtonPressed = false
    private var userAPIChoice: UserAPIChoice = .ticketMaster //TODO: refactor to take in user choice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()

    }
    
    private func configureNavBar() {
        if userAPIChoice == .ticketMaster {
            navigationItem.title = "Ticket Master Events"
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(changeView(_:)))
        } else {
            navigationItem.title = "Rijks Museum Collection"
            navigationItem.rightBarButtonItem?.accessibilityElementsHidden = true
            navigationItem.rightBarButtonItem?.isEnabled = false

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
    private func getEvents(city: String, keyword: String) {
        TicketMasterAPI.getEvents(city: city, search: keyword) { [weak self] (result) in
            switch result {
            case .failure(let eventsError):
                print(eventsError)
            case .success(let events):
                self?.events = events
            }
        }
    }
    @objc private func searchButtonPressed(_ sender: UIButton) {
        //if user api is ticket master
        if userAPIChoice == .ticketMaster {
            guard let keyword = searchTableView.searchBarOne.searchTextField.text, !keyword.isEmpty,
                let city = searchTableView.searchBarTwo.searchTextField.text, !city.isEmpty else {
                    //add warning to fill all fields
                    print("missing fields")
                    return
            }
            getEvents(city: city, keyword: keyword)
            searchTableView.searchBarOne.resignFirstResponder()
            searchTableView.searchBarTwo.resignFirstResponder()
        } else {
            searchTableView.searchBarTwo.isHidden = true
            guard let artSearch = searchTableView.searchBarOne.searchTextField.text, !artSearch.isEmpty else {
                print("missing fields")
                return
            }
            //api call
            searchTableView.searchBarOne.resignFirstResponder()
        }
    }
    
    
}
//extension SearchEventsController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return events.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        //need cell
//    }
//
//
//}
