//
//  VideoCollectionViewCell.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 19.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var menu: Video? {
        didSet {
            nameLabel.text = menu?.name
            if let image = menu?.imageName {
                imageView.image = UIImage(named: image)
            }
        }
    }
}