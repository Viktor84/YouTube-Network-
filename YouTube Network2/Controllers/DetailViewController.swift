//
//  DetailViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 21.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var videoId = "QJNsP1o1Fj8"

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
    
    @IBOutlet weak var videoIdLabel: UILabel! {
        didSet {
            videoIdLabel.text = menu?.videoGroup
            videoId = (menu?.videoGroup ?? nil) ?? "KNAQ3Y8PGkM"
        }
    }
    
    @IBOutlet var youTubePlayer2Test: YTPlayerView!
    
    var menu: Video?
    var displayVideoButton = UIButton() //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setNavigatioBar()
        youTubePlayer2Test.load(withVideoId: videoId)
    }
    
    func setNavigatioBar() {
        //navigationItem.largeTitleDisplayMode = .automatic
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
