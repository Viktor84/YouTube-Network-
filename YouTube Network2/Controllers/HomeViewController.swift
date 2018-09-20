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
    
    var itemMenuArray: [Menu] = {
        var blankMenu = Menu()
        blankMenu.name = "Cities"
        blankMenu.imageName = "cities"
        
        var blankMenu1 = Menu()
        blankMenu1.name = "Ideas"
        blankMenu1.imageName = "ideas"
        
        var blankMenu2 = Menu()
        blankMenu2.name = "Ideas2"
        blankMenu2.imageName = "ideas2"
        
        var blankMenu3 = Menu()
        blankMenu3.name = "Goals"
        blankMenu3.imageName = "goals"
        
        return [blankMenu, blankMenu1, blankMenu2, blankMenu3]
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
        
        APIService.sharedInstance.postVideoToYouTube()
        //updateData()
        //var tabBarItem = UITabBarItem()
        //tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        //tabBarItem.image = #imageLiteral(resourceName: "HomeIcon")
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
        return itemMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            
            itemCell.menu = itemMenuArray[indexPath.row]
            
            return itemCell
        }
        return UICollectionViewCell()
    }
}

