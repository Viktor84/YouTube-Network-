//
//  DefaultsStorage.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 22.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation

class DefaultsStorage: LocalStorage {
    
    let keyUserLogin = "keyUserLogin" 
    
    var userLogin: String? {
        get {
            return (UserDefaults.standard.object(forKey: keyUserLogin) as? String)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: keyUserLogin)
            UserDefaults.standard.synchronize()
        }
    }
}
