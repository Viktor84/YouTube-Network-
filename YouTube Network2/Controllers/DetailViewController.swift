//
//  DetailViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 21.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videoId = "QJNsP1o1Fj8"
    var dataComments: [Comments] = {
        
        var blankComment = Comments()
        blankComment.name = "Jon"
        blankComment.comments = "Cool video"
        blankComment.imageUser = UIImage(named: "image1")
        
        var blankComment1 = Comments()
        blankComment1.name = "Tom"
        blankComment1.comments = "Fan __)))"
        blankComment1.imageUser = UIImage(named: "image3")
        
        var blankComment2 = Comments()
        blankComment2.name = "Jon"
        blankComment2.comments = "Contributes to the preparation and implementation of the system Contributes to the preparation and implementation of the system"
        blankComment2.imageUser = UIImage(named: "image1")
        
        return [blankComment, blankComment1, blankComment2]
    }()

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
    
    @IBOutlet var youTubePlayer2Test: YTPlayerView!  {
        didSet {
            videoId = (menu?.videoGroup ?? nil) ?? "KNAQ3Y8PGkM"
        }
    }
    
    var menu: Video?
    var displayVideoButton = UIButton() //
    
    @IBOutlet weak var commentTableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataComments.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentsCell
        
        cell.configure(comment: dataComments[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setNavigatioBar()
        youTubePlayer2Test.load(withVideoId: videoId)
        commentTableView.estimatedRowHeight = 80.0
        commentTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setNavigatioBar() {
        navigationItem.largeTitleDisplayMode = .automatic
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
