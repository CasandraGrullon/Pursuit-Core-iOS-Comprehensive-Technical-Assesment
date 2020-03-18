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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doneEditingButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    }
}
