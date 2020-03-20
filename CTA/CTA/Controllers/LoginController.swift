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
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var accountState: AccountState = .existingUser
    private var authSession = AuthenticationSession()
    private var userApiChoice = ""
    
    private var apiChoices = ["Rijksmuseum", "Ticket Master"] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseAppExperience.text = ""
        collectionView.isHidden = true
        configureCollectionView()
        textfieldDelegates()
    }
    private func textfieldDelegates() {
        passwordTextfield.delegate = self
        emailTextfield.delegate = self
    }
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "APICell", bundle: nil), forCellWithReuseIdentifier: "apiCell")
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
            chooseAppExperience.text = "Choose an App Experience"
            
            collectionView.isHidden = false
            collectionView.isUserInteractionEnabled = true
            logInButton.isEnabled = false
            logInButton.backgroundColor = .gray
        } else {
            logInButton.setTitle("LOGIN", for: .normal)
            promptLabel.text = "Don't have an acount?"
            signUpHereButton.setTitle("SIGN UP HERE", for: .normal)
            chooseAppExperience.text = ""
            collectionView.isHidden = true
            logInButton.isEnabled = true
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
        DatabaseService.shared.createDBUser(authDataResult: authDataResult) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success:
                DispatchQueue.main.async {
                    self?.grabAPIChoice(api: self?.userApiChoice ?? "")
                    self?.navigateToMainApp()
                }
            }
        }
    }
    
    private func navigateToMainApp() {
        UIViewController.showViewController(storyboardName: "MainApp", viewcontrollerID: "MainAppTabBar")
    }
    
    private func grabAPIChoice(api: String) {
        DatabaseService.shared.updateUserAPIChoice(apiChoice: api) { [weak self] (result) in
            switch result {
                case .failure(let error):
                    print("error getting api choice \(error)")
                case .success:
                print("\(api) was chosen")
                self?.userApiChoice = api
            }
        }
    }
}
    
extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 4
        let maxSize: CGFloat = UIScreen.main.bounds.width
        let numberOfItems: CGFloat = 2
        let totalSpace: CGFloat = (2 * itemSpacing) + (numberOfItems) * itemSpacing
        let itemWidth: CGFloat = (maxSize - totalSpace) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let apiChoice = apiChoices[indexPath.row]
        //grabAPIChoice(api: apiChoice)
        userApiChoice = apiChoice
        print("selected: \(apiChoice)")
        logInButton.isEnabled = true
        logInButton.backgroundColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)

    }
}
extension LoginController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apiChoices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "apiCell", for: indexPath) as? APICell else {
            fatalError("could not cast to api cell")
        }
        let apichoice = apiChoices[indexPath.row]
        cell.configureCell(api: apichoice)
        return cell
    }

    
}
