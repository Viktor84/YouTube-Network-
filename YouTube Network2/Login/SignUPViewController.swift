//
//  SignUPViewController.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 11.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import UIKit

class SignUPViewController: UIViewController {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
 /*
    @IBAction func signUpAction(_ sender: Any) {
       // if userName.text != userName
        //if password.text != password. {
        guard let userName = userName.text,
        let password = password.text else {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
        if error == nil {
            self.performSegue(withIdentifier: "signupToHome", sender: self)
        }
        else{
            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    } */
}
