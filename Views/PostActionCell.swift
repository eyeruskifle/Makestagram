//
//  PostActionCell.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 7/5/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit


protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell {
   //properties
    weak var delegate: PostActionCellDelegate?

    static let height: CGFloat = 46
    //Subviews
    
    @IBOutlet weak var likeButton: PostActionCell!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    //Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }
    
}

