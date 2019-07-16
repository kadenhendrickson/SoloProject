//
//  RequestResponseTableViewCell.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class RequestResponseTableViewCell: UITableViewCell {
    
    var request: Request? {
        didSet {
            updateViews()
        }
    }
    

    @IBOutlet weak var projectNameTextLabel: UILabel!
    @IBOutlet weak var clientNameTextLabel: UILabel!
    @IBOutlet weak var dateSubmittedTextLabel: UILabel!
    @IBOutlet weak var statusTextLabel: UILabel!
    

    
    func updateViews(){
        guard let request = request else {return}
        projectNameTextLabel.text = request.projectName
        clientNameTextLabel.text = request.usersFullName
        //dateSubmittedTextLabel.text = request.timestamp as a string
        statusTextLabel.text = request.status
    }
}
