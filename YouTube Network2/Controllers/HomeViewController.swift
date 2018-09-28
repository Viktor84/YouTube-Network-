//
//  HomeViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 17.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var itemVideoArray: [Video] = {
        var blankVideo = Video()
        blankVideo.name = "Cities"
        blankVideo.imageName = "cities"
        
        var blankVideo1 = Video()
        blankVideo1.name = "Ideas"
        blankVideo1.imageName = "ideas"
        
        var blankVideo2 = Video()
        blankVideo2.name = "Ideas2"
        blankVideo2.imageName = "ideas2"
        
        var blankVideo3 = Video()
        blankVideo3.name = "Goals"
        blankVideo3.imageName = "goals"
        
        return [blankVideo, blankVideo1, blankVideo2, blankVideo3]
    }()

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var listView: UIView!
    
    fileprivate var items: [JSONItems] = [] {
        didSet {
            print("ITEMS: ", items)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigation()
        //updateData()
        //collectionView.dataSource = self
        //collectionView.delegate = self
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


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemVideoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? VideoCollectionViewCell {
            
            itemCell.menu = itemVideoArray[indexPath.row]
            
//            let view = UIView(frame: itemCell.bounds)
//            view.backgroundColor = UIColor.red
//            itemCell.selectedBackgroundView = view
            
            return itemCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = itemVideoArray[indexPath.row]
        
       // menu.contentView.backgroundColor = UIColor.cyan 

        self.performSegue(withIdentifier: "showVideo", sender: menu)
    } 
}

