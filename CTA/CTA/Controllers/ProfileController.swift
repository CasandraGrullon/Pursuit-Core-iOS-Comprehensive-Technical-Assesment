//
//  ProfileController.swift
//  CTA
//
//  Created by casandra grullon on 3/18/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class ProfileController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var appExperienceImage: UIImageView!
    @IBOutlet weak var appExpViewColor: UIView!
    @IBOutlet weak var apiNameLabel: UILabel!
    
    private var apiChoice = UserSession.shared.getAppUser()?.apiChoice
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    private func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        usernameLabel.text = user.displayName ?? "no display name"
        emailLabel.text = user.email ?? "no email"
        if apiChoice == "Rijksmuseum" {
            appExpViewColor.backgroundColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            appExperienceImage.image = #imageLiteral(resourceName: "museum")
        } else {
            appExpViewColor.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            appExperienceImage.image = #imageLiteral(resourceName: "ticketmaster")
        }
        apiNameLabel.text = apiChoice
        profileImage.kf.setImage(with: user.photoURL)
    }


    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "EditController")
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("could not sign out \(error)")
        }
    }
    
}
