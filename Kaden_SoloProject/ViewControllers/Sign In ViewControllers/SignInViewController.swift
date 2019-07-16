//
//  SignInViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/15/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.tag = 0
        passwordTextField.tag = 1

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        triggerSignIn()
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toCreateAccountVC", sender: nil)
        resignAllTextFields()
    }
    @IBAction func userTappedView(_ sender: Any) {
        resignAllTextFields()
    }
    
    
    //Helper Functions:
    func resignAllTextFields() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func alertUser(withMessage message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func triggerSignIn() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error signing in, invalid credentials: \(error.localizedDescription)")
                self.alertUser(withMessage: "Incorrect username or password!")
                return
            }
            if let result = result {
                self.resignAllTextFields()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let requestViewController = storyboard.instantiateViewController(withIdentifier: "requestVC")
                UIApplication.shared.windows.first?.rootViewController = requestViewController
                let userID = result.user.uid
                UserController.shared.fetchCurrentUserWith(userID: userID, completion: { (user) in
                    UserController.shared.currentUser = user
                })
            }
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let passwordField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            triggerSignIn()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


