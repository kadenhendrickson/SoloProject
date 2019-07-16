//
//  ConfirmDateViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class ConfirmDateViewController: UIViewController {
    
    var request: Request?
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectAddressLabel: UILabel!
    @IBOutlet weak var projectClientName: UILabel!
    @IBOutlet weak var projectStatusLabel: UILabel!
    @IBOutlet weak var dateOneButton: UIButton!
    @IBOutlet weak var dateTwoButton: UIButton!
    @IBOutlet weak var dateThreeButton: UIButton!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var requestActionButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dateOneButtonClicked(_ sender: Any) {
        resetButtonColor()
        dateOneButton.backgroundColor = .green
        selectedDateLabel.text = ""
        selectedDateLabel.text = dateOneButton.titleLabel?.text
        request?.chosenDate = request?.userDateOne
    }
    @IBAction func dateTwoButtonClicked(_ sender: Any) {
        resetButtonColor()
        dateTwoButton.backgroundColor = .green
        selectedDateLabel.text = ""
        selectedDateLabel.text = dateTwoButton.titleLabel?.text
        request?.chosenDate = request?.userDateTwo
    }
    @IBAction func dateThreeButtonClicked(_ sender: Any) {
        resetButtonColor()
        dateThreeButton.backgroundColor = .green
        selectedDateLabel.text = ""
        selectedDateLabel.text = dateThreeButton.titleLabel?.text
        request?.chosenDate = request?.userDateThree
    }
    @IBAction func requestActionButtonClicked(_ sender: Any) {
        guard let request = request, selectedDateLabel.text != "Pick a Date above!",
                let chosenDate = request.chosenDate else {presentAlert(withMessage: "Please pick a date!"); return}
        RequestController.shared.updateRequestStatusAndDateWith(requestID: request.requestID, chosenDate: chosenDate, status: StatusConstants.inProgressKey)
        request.status = StatusConstants.inProgressKey
        navigationController?.popViewController(animated: true)
    }
    
    func presentAlert(withMessage: String) {
        let alertController = UIAlertController(title: nil, message: withMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func updateViews() {
        guard let request = request else {return}
        projectNameLabel.text = request.projectName
        projectAddressLabel.text = request.address
        projectClientName.text = request.usersFullName
        projectStatusLabel.text = request.status
        dateOneButton.setTitle(request.userDateOne.toString(dateFormat: .long), for: .normal)
        dateTwoButton.setTitle(request.userDateTwo.toString(dateFormat: .long), for: .normal)
        dateThreeButton.setTitle(request.userDateThree.toString(dateFormat: .long), for: .normal)
        selectedDateLabel.text = "Pick a Date above!"
    }
    
    func resetButtonColor() {
        dateOneButton.backgroundColor = .clear
        dateTwoButton.backgroundColor = .clear
        dateThreeButton.backgroundColor = .clear
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
