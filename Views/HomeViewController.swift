//
//  HomeViewController.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 6/30/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class HomeViewController:UIViewController{
    override func viewDidLoad() {
        print("--------")
        print(Auth.auth().currentUser?.email )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("--------")

        print(Auth.auth().currentUser?.email)
    }
}
