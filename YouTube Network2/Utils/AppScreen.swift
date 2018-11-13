//
//  AppScreen.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 21.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case profile = "Profile"
    
}
final class StoryBoardUtils {
    
    //TODO: getController
    class func getViewController(_ viewId: String) -> UIViewController? {
        
        switch viewId {
            
        case "HomeViewController":
           return UIStoryboard(name: Storyboard.main.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewId) as! HomeViewController
            
        case "SignUPViewController":
           return UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: viewId) as! SignUPViewController
            
        default:
            return nil
        }
    }
}
