//
//  LikeService.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 7/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct LikeService {
    static func create(for post: Post, success: @escaping (Bool) -> Void) {
        //check the post has a key and return false if there is not.
        guard let key = post.key else {
            return success (false)
        }
        //create a reference to the current user's UID,build the location of where we'll store the data for liking the post.
        let currrentUID = User.current.uid
        
        let likesRef = Database.database().reference().child("postLikes").child(key).child(currrentUID)
        likesRef.setValue(true) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            //In the code above, we add code in the completion block that increments the like_count of a post after a post has been liked
            let likeCountRef = Database.database().reference().child("posts").child(post.poster.uid).child(key).child("like_count")
            likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
                let currentCount = mutableData.value as? Int ?? 0
                
                mutableData.value = currentCount + 1
                
                return TransactionResult.success(withValue: mutableData)
            }, andCompletionBlock: { (error, _, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    success(false)
                } else {
                    success(true)
                }
            })
        }
    }
    
    static func delete(for post: Post, success: @escaping (Bool) -> Void) {
        guard let key = post.key else {
            return success (false)
        }

    
        let likesRef = Database.database().reference().child("postLikes").child(key).child(User.current.uid)
        likesRef.setValue(nil) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }
            
        }
        let likeCountRef = Database.database().reference().child("posts").child(post.poster.uid).child(key).child("like_count")
        likeCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
            let currentCount = mutableData.value as? Int ?? 0
            mutableData.value = currentCount - 1
            
            
            return TransactionResult.success(withValue: mutableData)
        }, andCompletionBlock: { (error, _, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            } else {
                success(true)
            }
        })
    }
    
    static func isPostLiked(_ post: Post, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        guard let postKey = post.key else {
            assertionFailure("Error: post must have key.")
            return completion(false)
        }
        
        let likesRef = Database.database().reference().child("postLikes").child(postKey)
        likesRef.queryEqual(toValue: nil, childKey: User.current.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    static func setIsLiked(_ isLiked: Bool, for post: Post, success: @escaping (Bool) -> Void) {
        if isLiked {
            create(for: post, success: success)
        } else {
            delete(for: post, success: success)
        }
    }
    
}















