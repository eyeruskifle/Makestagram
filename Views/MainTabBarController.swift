//
//  File.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 7/3/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this part of the code can be thought as a closure, a closure can be thought as a function with out a name
        photoHelper.completionHandler = { image in
            print("handle image")
        }
        // we set the MainTabViewController as a delegate
        delegate = self
        
        // we change the tab bar from default gray to black
        tabBar.unselectedItemTintColor = .black
    }
}


extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            //present photot taking action
            photoHelper.presentActionSheet(from: self)
            return false }
        else {
            return true
        }
    }
}


let photoHelper = MGPhotoHelper()

