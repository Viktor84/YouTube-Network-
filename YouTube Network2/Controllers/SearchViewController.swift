//
//  SearchViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 19.09.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var displayVideoButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigation()
    }
    
    func initNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
