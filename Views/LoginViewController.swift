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
            return
        }
        
        guard let user = user else {return}
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        
        //when existing user comes redirect them to the main storyboard by setting the window's root view controller
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            
            UserService.show(forUID: user.uid) { (user) in
                
                if let user = user {
                    // handle existing user
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    let initialViewController = UIStoryboard.initialViewController(for: .main)
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
                else {
                    // handle new user
                    self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                }
                
            }
            }
        )
    }
    
}
