//
//  CreateAccountViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/15/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController
{
    
    let imagePicker = ImagePickerHelper()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAccountCreationButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func selectImageButtonTapped(_ sender: Any) {
        imagePicker.presentImagePicker(for: self)
        
    }
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        triggerSignIn()
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        resignAllTextFields()
    }
    
    @IBAction func userSwipedDown(_ sender: Any) {
        resignAllTextFields()
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardRectangle = keyboardSize.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardHeight
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardRectangle = keyboardSize.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += keyboardHeight
        }
    
    }
    
    
    func triggerSignIn() {
        guard let profileImage = profileImage.image else {alertUser(withMessage: "Please choose a profile picture!"); return}
        
        guard let fullName = fullNameTextField.text, fullName != "", fullName.count < 20 else {
            alertUser(withMessage: "Please make sure you gave us your full name, and that it is less than 20 characters!"); return}
        
        guard let companyName = companyNameTextField.text, companyName != "", companyName.count < 20 else {
            alertUser(withMessage: "Please make sure you gave us your company name and that it is less than 20 characters"); return}
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {alertUser(withMessage: "please input a username and password!"); return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("There was an error creating the user!: \(error.localizedDescription)")
                self.alertUser(withMessage: "\(error.localizedDescription)")
                return
            }
            
            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = fullName
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    self.alertUser(withMessage: "\(error.localizedDescription)")
                    print("There was a problem adding the displayName: \(error.localizedDescription)")
                }
            })
            
            if let result = result {
                let userID = result.user.uid
                UserController.shared.CreateUser(userID: userID, fullName: fullName, email: email, companyName: companyName, profileImage: profileImage, completion: { (success) in
                    if success {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let requestVC = storyboard.instantiateViewController(withIdentifier: "requestVC")
                        UIApplication.shared.windows.first?.rootViewController = requestVC
                    }
                })
            }
            
        }
    }
    
    func resignAllTextFields() {
        fullNameTextField.resignFirstResponder()
        companyNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
        
        func alertUser(withMessage message: String){
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }

}

extension  CreateAccountViewController: ImagePickerHelperDelegate {
    func fireActionsForSelectedImage(_ image: UIImage) {
        resignAllTextFields()
        profileImage.image = image
        selectImageButton.setTitle("", for: .normal)
        selectImageButton.layer.borderWidth = 0
    }
}
