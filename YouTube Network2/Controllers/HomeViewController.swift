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

