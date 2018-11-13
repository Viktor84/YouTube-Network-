//
//  LoginViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 11.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func siginInAction(_ sender: Any) {
        let funcLogin = UserService() 
            if let email = email.text,
                let password = password.text {
                       funcLogin.testLogin(email: email, password: password, completion: { [weak self] result in
                        guard result else {
                            return
                        }
                        
                        DispatchQueue.main.async { [weak self] in
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            if let secondViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                                print(">>>>>navigationController:", self?.navigationController ?? "none"); self?.navigationController?.pushViewController(secondViewController, animated: false)
                            }
                        }
                })
        }
    }
    
    @IBAction func siginUPViewController(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("navigationController:", navigationController)
    }
}

extension UITextField{
    @IBInspectable var placeHolderColorLogin: UIColor? {
        get {
            return self.placeHolderColorLogin
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
}
