//
//  LoginController.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState {
    case newUser
    case existingUser
}

class LoginController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpHereButton: UIButton!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var chooseAppExperience: UILabel!
    @IBOutlet weak var apiButtonStack: UIStackView!
    
    
    private var accountState: AccountState = .existingUser
    private var authSession = AuthenticationSession()
    private var selectedAPI: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextfield.delegate = self
        emailTextfield.delegate = self
        chooseAppExperience.text = ""
        apiButtonStack.isHidden = true
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text, !email.isEmpty, let password = passwordTextfield.text, !password.isEmpty else {
            return
        }
        continueLoginFlow(email: email, password: password)
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        accountState = accountState == .existingUser ? .newUser : .existingUser
        //TODO: add animations
        if accountState == .newUser {
            logInButton.setTitle("Create Account", for: .normal)
            promptLabel.text = "Already have account?"
            signUpHereButton.setTitle("LOGIN HERE", for: .normal)
            chooseAppExperience.text = "Choose App Experience"
            apiButtonStack.isHidden = false
        } else {
            logInButton.setTitle("LOGIN", for: .normal)
            promptLabel.text = "Don't have an acount?"
            signUpHereButton.setTitle("SIGN UP HERE", for: .normal)
            chooseAppExperience.text = ""
            apiButtonStack.isHidden = true
        }
        
    }
    
    private func continueLoginFlow(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signInExistingUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    //TODO: add show alert
                    print(error)
                case .success:
                    DispatchQueue.main.async {
                        self?.navigateToMainApp()
                    }
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    //TODO: add show alert
                    print(error)
                case .success(let authDataResult):
                    self?.createUser(authDataResult: authDataResult)
                }
            }
        }
    }
    
    private func createUser(authDataResult: AuthDataResult) {
        
    }
    
    private func navigateToMainApp() {
        UIViewController.showViewController(storyboardName: "MainApp", viewcontrollerID: "MainAppTabBar")
    }
    
    @IBAction func museumButtonPressed(_ sender: UIButton) {
        selectedAPI = "Rijks Museum"
    }
    
    @IBAction func ticketButtonPressed(_ sender: UIButton) {
        selectedAPI = "Ticket Master"
    }
}
extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


