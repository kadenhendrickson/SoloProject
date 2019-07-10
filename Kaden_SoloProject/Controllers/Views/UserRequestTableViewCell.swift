//
//  UserRequestTableViewCell.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/10/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class UserRequestTableViewCell: UITableViewCell {
    
    var request: Request? {
        didSet{
            updateViews()
        }
    }
    

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var addressTextLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    func updateViews() {
        self.projectNameLabel.text = request?.projectName
        self.addressTextLabel.text = request?.address
        self.statusTextLabel.text = request?.status
        
        switch request?.status {
        case StatusConstants.pendingKey:
            self.statusImageView.tintColor = UIColor.red
        case StatusConstants.inProgressKey:
            self.statusImageView.tintColor = UIColor.orange
        case StatusConstants.awaitingPaymentKey:
            self.statusImageView.tintColor = UIColor.blue
        case StatusConstants.completeKey:
            self.statusImageView.tintColor = UIColor.green
        default:
            print("How did you find me?")
        }
    }
    
   


}
