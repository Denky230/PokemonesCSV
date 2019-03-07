//
//  EditProfileViewController.swift
//  PokemonesCSV
//
//  Created by dmorenoar on 07/03/2019.
//  Copyright © 2019 Oscar Rossello. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var inputName: UITextField!
    
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
        inputName.text = loggedUser.name
    }
    
    @objc func cancel() {
        // Go back to profile
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func confirm() {
        // Make sure name text field is not empty
        let name = inputName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if name != "" {
            // Update user name
            loggedUser.name = name
        }
        
        // Save user data in phone memory
        userDefaults.saveUserProfileData()
        
        // Go back to profile
        navigationController?.popToRootViewController(animated: true)
    }
}
