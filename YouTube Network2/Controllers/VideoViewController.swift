//
//  ViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 27.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet var youtubePlayer: YTPlayerView!
    
    let videoGroup = "QJNsP1o1Fj8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //youtubePlayer.load(withVideoId: videoGroup)
        self.title = "YouTubeVC"
    }
}
