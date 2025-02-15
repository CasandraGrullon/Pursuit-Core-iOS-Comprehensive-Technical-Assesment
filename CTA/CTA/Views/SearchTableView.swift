//
//  SearchTableView.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class SearchTableView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 13
    }
    
    public lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    public lazy var searchBarOne: UITextField = {
        let searchbar = UITextField()
        searchbar.borderStyle = .line
        searchbar.placeholder = "search by event type"
        return searchbar
    }()
    public lazy var searchBarTwo: UITextField = {
        let searchbar = UITextField()
        searchbar.borderStyle = .line
        searchbar.placeholder = "search by zipcode"
        return searchbar
    }()
    public lazy var searchStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchBarOne, searchBarTwo])
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    public lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        return button
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
        searchBarConstraints()
        searchButtonConstraints()
        tableConstraints()
    }
    private func searchBarConstraints() {
        addSubview(searchStack)
        searchStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            searchStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            searchStack.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func searchButtonConstraints() {
        addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: searchStack.trailingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            searchButton.widthAnchor.constraint(equalToConstant: 44),
            searchButton.heightAnchor.constraint(equalTo: searchButton.widthAnchor)
        ])
    }
    private func tableConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchStack.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
