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
        
        initNavigation()
        
        //APIService.sharedInstance.postVideoToYouTube()
        //updateData()
        //collectionView.dataSource = self
        //collectionView.delegate = self
        //setupNavigationBar() // <--
    }
    
    func initNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
//    func setupNavigationBar() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVideo" {
            if let vc = segue.destination as? DetailViewController {
                let menu = sender as? Menu 
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
        return itemMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuCollectionViewCell {
            
            itemCell.menu = itemMenuArray[indexPath.row]
            
//            let view = UIView(frame: itemCell.bounds)
//            view.backgroundColor = UIColor.red
//            itemCell.selectedBackgroundView = view
            
            return itemCell
        }
        
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menu = itemMenuArray[indexPath.row]
        
       // menu.contentView.backgroundColor = UIColor.cyan

        self.performSegue(withIdentifier: "showVideo", sender: menu)
    } 
}

