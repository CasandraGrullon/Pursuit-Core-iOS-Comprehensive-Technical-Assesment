//
//  EditController.swift
//  CTA
//
//  Created by casandra grullon on 3/18/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var updateLabel: UILabel!
    
    private var selectedAPI = String() {
        didSet {
            self.userApiChoice = selectedAPI
            DispatchQueue.main.async {
                self.appColors()
                self.viewWillAppear(true)
            }
        }
    }
    private let storageService = StorageService()
    private var userApiChoice = UserSession.shared.getAppUser()?.apiChoice
    
    private var apiChoices = ["Rijksmuseum", "Ticket Master"] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    private var selectedImage: UIImage? {
        didSet{
            DispatchQueue.main.async {
                self.profilePicture.image = self.selectedImage
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        usernameTextfield.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "APICell", bundle: nil), forCellWithReuseIdentifier: "apiCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        appColors()
    }
    private func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        profilePicture.kf.setImage(with: user.photoURL)
        usernameTextfield.text = user.displayName
    }
    private func appColors() {
        if userApiChoice == "Rijksmuseum"{
            navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            editProfileButton.tintColor = #colorLiteral(red: 0.2345507145, green: 0.5768489242, blue: 0.4764884114, alpha: 1)
            view.backgroundColor = .darkGray
            collectionView.backgroundColor = .darkGray
            usernameTextfield.backgroundColor = .darkGray
            usernameTextfield.textColor = .white
            updateLabel.textColor = .white
        } else {
            navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            editProfileButton.tintColor = #colorLiteral(red: 1, green: 0.7171183228, blue: 0, alpha: 1)
            view.backgroundColor = .white
        }
    }
    @IBAction func editPictureButtonPressed(_ sender: UIButton) {
        showImagePicker()
    }
    
    @IBAction func doneEditingButtonPressed(_ sender: UIBarButtonItem) {
        uploadProfileChanges()

        let storyboard = UIStoryboard(name: "MainApp", bundle: nil)
        let profileVC = storyboard.instantiateViewController(identifier: "ProfileController")
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        tabBarController?.selectedIndex = 2
    }
    
    private func grabAPIChoice(api: String) {
        DatabaseService.shared.updateUserAPIChoice(apiChoice: api) { [weak self] (result) in
            switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Unable to update user app experience", message: error.localizedDescription)
                    }
                case .success:
                self?.userApiChoice = api
            }
        }
    }
}
extension EditController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension EditController: UICollectionViewDelegateFlowLayout {
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
        let api = apiChoices[indexPath.row]
        selectedAPI = api
        grabAPIChoice(api: api)
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
            cell?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (completed) in
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [], animations: {
                cell?.transform = CGAffineTransform.identity
            })
        }
    }
}
extension EditController: UICollectionViewDataSource {
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
extension EditController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage = image
        dismiss(animated: true)
    }
}
extension EditController{
    private func showImagePicker() {
        let alertController = UIAlertController.init(title: "Edit Profile Picture", message: "", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(camera)
        }
        
        alertController.addAction(photoLibrary)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    private func uploadProfileChanges() {
        guard let username = usernameTextfield.text, !username.isEmpty, let selectedImage = selectedImage else {
                  DispatchQueue.main.async {
                      self.showAlert(title: "Missing Fields", message: "please fill in all required fields")
                  }
                  return
          }
        let resizeImage = UIImage.resizeImage(originalImage: selectedImage, rect: profilePicture.bounds)
          guard let user = Auth.auth().currentUser else {
              return
          }
          storageService.uploadPhoto(userId: user.uid, image: resizeImage) { [weak self] (result) in
              switch result {
              case .failure(let error):
                  DispatchQueue.main.async {
                      self?.showAlert(title: "Unable to update user image", message: error.localizedDescription)
                  }
              case .success(let url):
                self?.updateDataBaseUser(displayName: username, photoURL: url.absoluteString)
                let request = Auth.auth().currentUser?.createProfileChangeRequest()
                request?.displayName = username
                request?.photoURL = url
                request?.commitChanges(completion: { (error) in
                    if let error = error {
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Unable to update user profile", message: error.localizedDescription)
                        }
                    } else {
                        print("successfully updated profile")
                    }
                })
              }
          }
    }
    private func updateDataBaseUser(displayName: String, photoURL: String) {
        DatabaseService.shared.updateUser(displayName: displayName, photoURL: photoURL) { [weak self] (result) in
            switch result{
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Unable to update database user", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Profile Updated!", message: "")
                }
            }
        }
    }
}
