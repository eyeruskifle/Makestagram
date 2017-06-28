//
//  LoginViewController.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 6/26/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController : UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
     print ("login button tapped")
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        authUI.delegate = self
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            // 1
            guard let user = user
                else { return }
            
            // 2
            let userRef = Database.database().reference().child("users").child(user.uid)
            
            // 3
          //  userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                // 4 retrieve user data from snapshot
            userRef.observeSingleEvent(of: .value, with: { (snapshot) in
                // 1
                if let userDict = snapshot.value as? [String : Any] {
                    print("User already exists \(userDict.debugDescription).")
                } else {
                    print("New user!")
                }
            })
            
        }
            
        }
        
      //  print("handle user signup / login")
       
    }



