//
//  MainAppTabBar.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class MainAppTabBar: UITabBarController {

    private var apiChoice = UserSession.shared.getAppUser()?.apiChoice
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if apiChoice == "Ticket Master" {
            tabBar.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        } else {
            tabBar.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        }
    }
    

}
