//
//  EditProfileViewController.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 07/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fillUserData()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Edit Profile"
        setupNavigationBarButtons()
    }
    func setupNavigationBarButtons() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let confirmButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(confirm))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = confirmButton
    }
    
    func fillUserData() {
        name.text = loggedUser.name
        image.image = loggedUser.image == nil ?
            UIImage(named: "profile_unselected") : loggedUser.image
    }
    
    @objc func cancel() {
        // Go back to profile
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func confirm() {
        // Make sure name text field is not empty
        let inName = name.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if inName != "" {
            // Update user name
            loggedUser.name = inName
        }
        
        // Save user data in phone memory
        userDefaults.saveUserProfileData()
        
        // Go back to profile
        navigationController?.popToRootViewController(animated: true)
    }
}
