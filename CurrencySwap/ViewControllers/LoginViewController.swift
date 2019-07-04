//
//  LoginViewController.swift
//  CurrencySwap
//
//  Created by Admin on 2019-07-03.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    let loginToList = "homeViewController"
    var firstTime: Bool = false
    
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    var user1: User!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    @IBAction func loginDidTouch(_ sender: Any) {
        guard
            let email = textFieldLoginEmail.text,
            let password = textFieldLoginPassword.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func signUpDidTouch(_ sender: Any) {
        
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            let emailField = alert.textFields![0]
            let passwordField = alert.textFields![1]
            
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
                if error == nil {
                    self.firstTime = true
                    Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
                                       password: self.textFieldLoginPassword.text!)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }  
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Auth.auth().addStateDidChangeListener() { auth, user in
//            if user != nil {
//                self.performSegue(withIdentifier: self.loginToList, sender: nil)
//                self.textFieldLoginEmail.text = nil
//                self.textFieldLoginPassword.text = nil
//            }
//        }
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                guard let user = user else { return }
                
                
                self.user1 = User(uid: user.uid, email: user.email!)
                let usersRef = Database.database().reference(withPath: "online")
                let allPostData = Database.database().reference(withPath: "allPost")
                
                if(self.firstTime){
                    let currentUserRef1 = allPostData.child(self.user1.uid)
                    currentUserRef1.setValue(self.user1.email)
                    self.firstTime = false
                }
                
                
                let currentUserRef = usersRef.child(self.user1.uid)
                currentUserRef.setValue(self.user1.email)
                
                currentUserRef.onDisconnectRemoveValue()
                
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
                self.textFieldLoginEmail.text = nil
                self.textFieldLoginPassword.text = nil
            }
           
            
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}
