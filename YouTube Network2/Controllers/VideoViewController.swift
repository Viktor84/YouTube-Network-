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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youtubePlayer.load(withVideoId: "6q3VKX_b1v8")
        //youtubePlayer.load(withVideoId: "QJNsP1o1Fj8")
        self.title = "YouTubeVC"
    }
}
