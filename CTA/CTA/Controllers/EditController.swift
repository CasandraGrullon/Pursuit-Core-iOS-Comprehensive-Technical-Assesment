//
//  EditController.swift
//  CTA
//
//  Created by casandra grullon on 3/18/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class EditController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var appUser: AppUser?
    //public var apiChoice = String()
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
        
    }
    @IBAction func editPictureButtonPressed(_ sender: UIButton) {
        showImagePicker()
    }

    
    @IBAction func doneEditingButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    }
    private func grabAPIChoice(api: String) {
        DatabaseService.shared.updateUserAPIChoice(apiChoice: api) {(result) in
            switch result {
                case .failure(let error):
                    print("error getting api choice \(error)")
                case .success:
                print("\(api) was chosen")
            }
        }
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
        grabAPIChoice(api: api)
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
}
