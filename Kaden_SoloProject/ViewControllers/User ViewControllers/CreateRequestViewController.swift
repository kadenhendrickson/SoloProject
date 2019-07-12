//
//  CreateRequestViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class CreateRequestViewController: UIViewController {
    
    lazy var datePicker: UIDatePicker = {
        let picker: UIDatePicker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    var dateOne: Date?
    var dateTwo: Date?
    var dateThree: Date?
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectAddressTextField: UITextField!
    @IBOutlet weak var projectSquareFootageTextField: UITextField!
    @IBOutlet weak var firstDateTextField: UITextField!
    @IBOutlet weak var secondDateTextField: UITextField!
    @IBOutlet weak var thirdDateTextField: UITextField!
    @IBOutlet weak var projectCommentsTextView: UITextView!
    @IBOutlet weak var submitRequestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstDateTextField.inputView = datePicker
        secondDateTextField.inputView = datePicker
        thirdDateTextField.inputView = datePicker
    }
    
    @IBAction func submitRequestButtonTapped(_ sender: Any) {
        guard projectNameTextField.text != "", let projectName = projectNameTextField.text else {presentAlert(withMessage: "Please give the project a name!"); return}
        guard projectAddressTextField.text != "", let address = projectAddressTextField.text else {presentAlert(withMessage: "Please enter an address, so I don't get lost!"); return}
        guard projectSquareFootageTextField.text != "", let squareFootage = projectSquareFootageTextField.text else {presentAlert(withMessage: "Please tell me how big the property is! (If you don't know type '0'"); return}
        guard let dateOne = dateOne else {presentAlert(withMessage: "Please make sure you gave me three date options!"); return}
        guard let dateTwo = dateTwo else {presentAlert(withMessage: "Please make sure you gave me three date options!"); return}
        guard let dateThree = dateThree else {presentAlert(withMessage: "Please make sure you gave me three date options!"); return}
        let comments = projectCommentsTextView.text ?? ""
        
        
        RequestController.shared.UserCreateRequest(projectName: projectName, address: address, squareFootage: squareFootage, comments: comments, userDateOne: dateOne, userDateTwo: dateTwo, userDateThree: dateThree)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: - Helper Functions
    @objc func dateChanged(sender: UIDatePicker) {
        if firstDateTextField.isEditing == true {
            self.firstDateTextField.text = dateFormatter.string(from: sender.date)
            dateOne = sender.date
        } else if secondDateTextField.isEditing == true {
            self.secondDateTextField.text = dateFormatter.string(from: sender.date)
            dateTwo = sender.date
        } else {
            self.thirdDateTextField.text = dateFormatter.string(from: sender.date)
            dateThree = sender.date
        }
    }
        
    func presentAlert(withMessage: String) {
        let alertController = UIAlertController(title: nil, message: withMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
        }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
