//
//  SignUPViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 11.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUPViewController: UIViewController {
    
 
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func signUpAction(_ sender: Any) {
        let testFunc = UserService()
        if let email = email.text,
            let password = password.text {
            testFunc.testRegister(email: email, password: password, completion: { [weak self] result in
                guard result else {
                    return
                }
        
            RepositoryManager.shared.storage.userLogin = email
                
                DispatchQueue.main.async { [weak self] in
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                   if let secondViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                    print("navigation:", self?.navigationController ?? "none");
                    self?.navigationController?.pushViewController(secondViewController, animated: false)
                }
            }
        })
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}
