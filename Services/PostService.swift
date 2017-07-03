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
        //convert the new post object in to a dictionary so that it can be written as JSON in our data base
        let dict = post.dictValue
        //write the data to the specified loaction
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        postRef.updateChildValues(dict)
        
    }
}











