//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 6/28/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase


class CreateUsernameViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        

        UserService.create(firUser, username: username) { (user) in
           
            //Create a new instance of our main storyboard
            guard let user = user else {
                return
            }
            User.setCurrent(user)
            
            //Check that the storyboard has an initial view controller
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            
            //Get reference to the current window and set the rootViewController to the initial view controller
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}


