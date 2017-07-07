//
//  FindFriendsCell.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 7/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit


protocol FindFriendsCellDelegate: class {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell)
}


class FindFriendsCell: UITableViewCell {
    
    weak var delegate: FindFriendsCellDelegate?
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
        
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        delegate?.didTapFollowButton(sender, on: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
