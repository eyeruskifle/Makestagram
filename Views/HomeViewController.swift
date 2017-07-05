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
    
    
    var posts = [Post]()
    // override func viewDidLoad() {
    //    print("--------")
    //  print(Auth.auth().currentUser?.email )
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //override func viewDidAppear(_ animated: Bool) {
    // print("--------")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
            
        }
        
        //   print(Auth.auth().currentUser?.email)
    }
    
}
//  UITable view data source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postImageCell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
        
    }
    
}


// UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        
        return post.imageHeight
    }
}











