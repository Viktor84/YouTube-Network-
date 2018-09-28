//
//  DetailViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 21.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit
//import youtube_ios_player_helper

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            guard let image = menu?.imageName else {return}
            imageView.image = UIImage(named: image)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = menu?.name 
        }
    }
    
    var menu: Video?
    
    var displayVideoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigatioBar()
    }
    
    func setNavigatioBar() {
        navigationItem.largeTitleDisplayMode = .automatic
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
