//
//  User.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 16.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import Firebase

enum UserKeys: String {
    case kName = "Name"
    case kEmail = "Email"
}


class User {
    
    let userID: String!
    var name: String!
    var email: String!
    
    let ref: FIRDatabaseReference?
    
    init(email: String, name: String) {
        self.userID = nil
        self.name = name
        self.email = email
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        userID = snapshot.key
        if let dict = snapshot.value as? [String: AnyObject] {
            name = dict[UserKeys.kName.rawValue] as! String
            email = dict[UserKeys.kEmail.rawValue] as! String
        } else {
            name = ""
            email = ""
        }
        
        ref = snapshot.ref
    }
}
