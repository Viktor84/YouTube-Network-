//
//  UserService.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 16.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import FirebaseAuth

final class UserService {
    
    class fileprivate weak var firManager: FIRManager? {
        get {
            return FIRManager.sharedInstance.initialize()
        }
    }

    func testRegister(email: String?, password: String?, completion: @escaping(_ result: Bool) ->()) {
        if let email = email,
            let password = password {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if let u = user {
                    completion(true)
                } else {
                    completion(false)
                }
                
                print("user: ", user)
                print("error: ", error)
            })
        }
    }
    
    func testLogin(email: String?, password: String?, completion: @escaping (_ result: Bool) ->()) {
        if let email = email,
            let password = password {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                print("userLogin: ", user)
                print("errorLogin: ", error)
                if let u = user {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }  
}
