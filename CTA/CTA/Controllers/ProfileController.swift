//
//  ProfileController.swift
//  CTA
//
//  Created by casandra grullon on 3/18/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProfileController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var appExperienceImage: UIImageView!
    @IBOutlet weak var appExpViewColor: UIView!
    @IBOutlet weak var apiNameLabel: UILabel!
    
    public var appUser: AppUser
    private var apiChoice = String()
    
    init?(coder: NSCoder, appUser: AppUser, apiChoice: String) {
        self.appUser = appUser
        self.apiChoice = apiChoice
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    private func updateUI() {
        getUserAPIChoice()
        if apiChoice == "Rijksmuseum" {
            appExpViewColor.backgroundColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            appExperienceImage.image = #imageLiteral(resourceName: "museum")
        } else {
            appExpViewColor.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            appExperienceImage.image = #imageLiteral(resourceName: "ticketmaster")
        }
        
        
    }
    private func getUserAPIChoice() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        DatabaseService.shared.getUserAPIChoice(userId: user.uid) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("could not get user api choice \(error)")
            case .success(let apichoice):
                DispatchQueue.main.async {
                    self?.apiNameLabel.text = apichoice
                    self?.apiChoice = apichoice
                }
                
            }
        }
    }

    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("could not sign out \(error)")
        }
    }
    
}
