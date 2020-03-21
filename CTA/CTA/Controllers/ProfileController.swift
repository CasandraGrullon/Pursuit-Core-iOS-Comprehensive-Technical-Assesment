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
import FirebaseFirestore

class ProfileController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var appExperienceImage: UIImageView!
    @IBOutlet weak var appExpViewColor: UIView!
    @IBOutlet weak var apiNameLabel: UILabel!
    
    public var profileListener: ListenerRegistration?
    public var apiChoice = String() {
        didSet {
            DispatchQueue.main.async {
                self.updateApiUI()
                self.viewWillAppear(true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getApiExperience()
        updateUserUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getApiExperience()
        updateUserUI()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        updateUserUI()
    }
    
    private func updateUserUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        usernameLabel.text = user.displayName ?? "no display name"
        emailLabel.text = user.email ?? "no email"
        profileImage.kf.setImage(with: user.photoURL)
    }
    private func updateApiUI() {
        if apiChoice == "Rijksmuseum" {
            appExpViewColor.backgroundColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            view.backgroundColor = .darkGray
            appExperienceImage.image = #imageLiteral(resourceName: "museum")
            apiNameLabel.text = apiChoice
            usernameLabel.textColor = .white
            emailLabel.textColor = .white
        } else if apiChoice == "Ticket Master"{
            appExpViewColor.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            appExperienceImage.image = #imageLiteral(resourceName: "ticketmaster")
            apiNameLabel.text = apiChoice
        } else {
            appExperienceImage.image = UIImage(systemName: "photo")
        }
    }
    private func getApiExperience() {
        DatabaseService.shared.getUserApiChoice { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to get user app experience", message: error.localizedDescription)
                }
            case .success(let apichoice):
                self?.apiChoice = apichoice
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
        let editVC = storyboard.instantiateViewController(identifier: "EditController")
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyboardName: "Login", viewcontrollerID: "LoginController")
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "Unable to sign out at this time", message: error.localizedDescription)
            }
        }
    }
    
}
