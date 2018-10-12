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
   // @IBOutlet weak var labelVideoGroup: UILabel!
    
    var videoCollectionViewCell: Video? {
        didSet {
            configureCell()
            
        }
    }
    
    func configureCell() {
        nameLabel.text = videoCollectionViewCell?.name
        // labelVideoGroup.text = videoCollectionViewCell?.videoGroup
        
        if let image = videoCollectionViewCell?.imageName {
            imageView.image = UIImage(named: image)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
