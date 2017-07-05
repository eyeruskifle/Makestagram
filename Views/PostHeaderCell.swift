//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by eyerusalem woldu on 7/5/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

class  PostHeaderCell: UITableViewCell {
    
    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("options button tapped")
        
    }
}
