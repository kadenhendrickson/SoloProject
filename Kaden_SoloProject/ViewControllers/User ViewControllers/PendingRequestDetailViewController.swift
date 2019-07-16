//
//  PendingRequestDetailViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class PendingRequestDetailViewController: UIViewController {
    
    @IBOutlet weak var requestNameLabel: UILabel!
    
    var request: Request?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
       
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let request = request else {print("There isnt a request"); return}
        self.requestNameLabel.text = request.projectName
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
