//
//  MainAppTabBar.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class MainAppTabBar: UITabBarController {
    private var userAPIChoice = "" {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
                self.viewWillAppear(true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiChoice()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getApiChoice()
    }
    private func getApiChoice() {
        DatabaseService.shared.getUserApiChoice { [weak self] (result) in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to fetch user experience", message: error.localizedDescription)
                }
            case .success(let api):
                self?.userAPIChoice = api
            }
        }
    }
    private func updateUI(){
        if userAPIChoice == "Ticket Master" {
            tabBar.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
        } else {
            tabBar.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
        }
    }
    
    
    
}
