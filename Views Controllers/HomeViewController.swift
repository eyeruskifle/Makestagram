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
import Kingfisher

class HomeViewController:UIViewController{
    
    func configureTableView() {
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
        tableView.separatorStyle = .none
    }
    
    var posts = [Post]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
            
        }
    }
}

//  UITable view data source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "postImageCell", for: indexPath) as! PostImageCell
        
        let imageURL = URL(string: post.imageURL)
        cell.PostImageView.kf.setImage(with: imageURL)
        
        return cell

    }
}
// UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
//    func tableView(_tableView: UITableViewCell, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let post = posts[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
//        
//        let imageURL = URL(string: post.imageURL)
//        cell.PostImageView.kf.setImage(with: imageURL)
//        
//        return cell
//    }
}











