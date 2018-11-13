//
//  HomeViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 17.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseDatabase


class HomeViewController: UIViewController {
    static let nibName = "VideoCollectionViewCell"
    static let cellIdentifier = "VideoCellID"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemVideoArray: [Video] = {
        var blankVideo = Video()
        blankVideo.name = "Cities"
        blankVideo.imageName = "cities"
        blankVideo.videoGroup = "49LdKKGDDGU"
        
        var blankVideo1 = Video()
        blankVideo1.name = "Ideas"
        blankVideo1.imageName = "ideas"
        blankVideo1.videoGroup = "c6yOxWf3A6g"
        
        var blankVideo2 = Video()
        blankVideo2.name = "Ideas2"
        blankVideo2.imageName = "ideas2"
        blankVideo2.videoGroup = "6q3VKX_b1v8"
        
        var blankVideo3 = Video()
        blankVideo3.name = "Goals"
        blankVideo3.imageName = "goals"
        blankVideo3.videoGroup = "QJNsP1o1Fj8"
        
        return [blankVideo, blankVideo1, blankVideo2, blankVideo3]
    }()
    
    fileprivate var items: [JSONItems] = [] {
        didSet {
            print("ITEMS: ", items)
        }
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: HomeViewController.nibName, bundle: nil)
        
        self.collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoCellID")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRDatabase.database().reference()
        initNavigation()
        initCollectionView()
        //updateData()
    }
    
    func initNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVideo" {
            if let vc = segue.destination as? DetailViewController {
                let menu = sender as? Video
                print(menu ?? "nil")
                vc.menu = menu
            }
        }
    }
    
    private func updateData() {
        APIService.sharedInstance.getAPI(completion: { [weak self] result in
            
            if let _result = result as? JSONResponse {
                self?.items = _result.items
            } else {
                self?.items = []
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemVideoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCellID", for: indexPath) as? VideoCollectionViewCell {
            
            itemCell.videoCollectionViewCell = itemVideoArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSize = CGSize(width: (collectionView.bounds.width - (3 * 2))/3, height: 120)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = itemVideoArray[indexPath.row]
        self.performSegue(withIdentifier: "showVideo", sender: menu)
    }
}

