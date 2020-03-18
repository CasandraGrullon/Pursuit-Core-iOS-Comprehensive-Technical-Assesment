//
//  SearchView.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import MapKit

class EventsSearchMapView: UIView {
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        return map
    }()
    public lazy var searchBarStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [postCodeSearch, keywordSearch])
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var postCodeSearch: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search by area code"
        return searchBar
    }()
    public lazy var keywordSearch: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search by event type"
        return searchBar
    }()
    public var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return cv
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
        mapViewConstraints()
        searchBarStackConstraints()
        collectionViewConstraints()
    }
    
    private func mapViewConstraints() {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    private func searchBarStackConstraints() {
        addSubview(searchBarStack)
        searchBarStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBarStack.topAnchor.constraint(equalTo: mapView.topAnchor),
            searchBarStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBarStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBarStack.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    private func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: mapView.heightAnchor, multiplier: 0.10)
        ])
    }
    
}
