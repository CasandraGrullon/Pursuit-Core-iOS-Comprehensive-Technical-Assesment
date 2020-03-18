//
//  DetailController.swift
//  CTA
//
//  Created by casandra grullon on 3/17/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    private let eventsDetailView = EventDetailView()
    
    override func loadView() {
        view = eventsDetailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
