//
//  PostService.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 7/3/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase


struct PostService {
    static func create(for image: UIImage) {
        //  let imageRef = Storage.storage().reference().child("test_image.jpg")
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLstring: urlString, aspectHeight: aspectHeight)
            //   print("image url: \(urlString)")
        }
    }
    private static func create(forURLstring urlString: String, aspectHeight: CGFloat) {
        //create a new post in a data base
        
        // create referance to a user ID
        let currentUser = User.current
        
        //initialized a new post using data passing in by the parameters
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        
        //create references to the important locations that we're planning to write data
        let rootRef = Database.database().reference()
        let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
        let newPostKey = newPostRef.key
        
        //Use our class method to get an array of all of our follower UIDs
        UserService.followers(for: currentUser) { (followerUIDs) in
            
            //construct a timeline JSON object where we store our current user's uid
            let timelinePostDict = ["poster_uid" : currentUser.uid]
            
            //create a mutable dictionary that will store all of the data we want to write to our database
            var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
            
            //add our post to each of our follower's timelines.
            for uid in followerUIDs {
                updatedData["timeline/\(uid)/\(newPostKey)"] = timelinePostDict
            }
            
            //We make sure to write the post we are trying to create.
            let postDict = post.dictValue
            updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
            
            //write our multi-location update to our database.
            rootRef.updateChildValues(updatedData)
            
            
            //convert the new post object in to a dictionary so that it can be written as JSON in our data base
            let dict = post.dictValue
            
            //write the data to the specified loaction
            let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
            postRef.updateChildValues(dict)
            
        }
        
    }
    static func show(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("posts").child(posterUID).child(postKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            
            LikeService.isPostLiked(post) { (isLiked) in
                post.isLiked = isLiked
                completion(post)
            }
        })
    }
    
}




