//
//  FIRManager.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 16.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import Firebase

class FIRManager {
    var rootRef = FIRDatabaseReference.init()
    var userRef = FIRDatabaseReference.init()
    var passwordRef = FIRDatabaseReference.init()
    
    
    static let sharedInstance = FIRManager()
    
    func initialize() -> FIRManager {
        rootRef = FIRDatabase.database().reference()
        
        userRef = rootRef.child("users")
        passwordRef = rootRef.child("password")
        
        return self
    }
}

