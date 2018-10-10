//
//  CommentsCell.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 09.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
  
    var comments = Comments()
    
    func configure(comment: Comments) {
    nameUserLabel.text = comment.name
    commentLabel.text = comment.comments
    imageUser.image = comment.imageUser
    }
}
