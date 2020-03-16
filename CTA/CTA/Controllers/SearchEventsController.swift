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
    
    override func loadView() {
        view = searchMapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
