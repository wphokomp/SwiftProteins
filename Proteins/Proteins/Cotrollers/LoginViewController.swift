//
//  LoginViewController.swift
//  Proteins
//
//  Created by William PHOKOMPE on 2018/11/27.
//  Copyright © 2018 William PHOKOMPE. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var touchIdLogin: UIButton!
    
    @IBAction func loginOnTouch(_ sender: Any) {
        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need your TouchID!", reply: {(Success, error) in
            if Success {
                print ("Success")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "AuthDone", sender: self.navigationController)
                }
                self.navigationController?.dismiss(animated: false, completion: nil)
            } else {
                self.showAlert(title: "Error", message: "Biometeric scan did not match!", actionTitle: "OK")
                print ("Error")
            }
        })
    }
    
    let context: LAContext = LAContext()
    
    @IBAction func loginOnClick(_ sender: Any) {
        //Theory of hitting the 42 api for authentication
        if username.text == "" || password.text == "" {
            self.showAlert(title: "Info", message: "Dude.... At least enter something", actionTitle: "Cummon!!!")
        } else {
            self.performSegue(withIdentifier: "AuthDone", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            loginButton.isEnabled = true
            username.isEnabled = true
            password.isEnabled = true
            touchIdLogin.isEnabled = false
        } else {
            loginButton.isEnabled = false
            username.isEnabled = false
            password.isEnabled = false
            touchIdLogin.isEnabled = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message:  message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
