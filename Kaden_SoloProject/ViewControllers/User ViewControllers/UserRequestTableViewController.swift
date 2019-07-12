//
//  UserRequestTableViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class UserRequestTableViewController: UITableViewController {
    
    var completedRequests: [Request]?
    var awaitingPaymentRequests: [Request]?
    var pendingAndInProgressRequests: [Request]?
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    var selectedSegment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pendingAndInProgressRequests = []
        populatePendingArray()
        
    }
    
    @IBAction func segmentControllerSectionTapped(_ sender: UISegmentedControl) {
        guard let currentUser = UserController.shared.currentUser else {return}
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegment = 0
        case 1:
            selectedSegment = 1
            if awaitingPaymentRequests == nil {
                awaitingPaymentRequests = []
                RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.awaitingPaymentKey) { (requests) in
                    self.awaitingPaymentRequests?.append(contentsOf: requests)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        case 2:
            selectedSegment = 2
            if completedRequests == nil {
                completedRequests = []
                RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.completeKey) { (requests) in
                    self.completedRequests?.append(contentsOf: requests)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        default:
            print("How did you find another section though?")
        }
    }
    
    //MARK: - Helper Functions
    func populatePendingArray() {
        guard let currentUser = UserController.shared.currentUser else {return}
        RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.pendingKey) { (requests) in
            self.pendingAndInProgressRequests?.append(contentsOf: requests)
        }
        RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.inProgressKey) { (requests) in
            self.pendingAndInProgressRequests?.append(contentsOf: requests)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedSegment {
        case 0:
            guard let pendingRequestArray = pendingAndInProgressRequests else {return 0}
            return pendingRequestArray.count
        case 1:
            guard let awaitingPaymentArray = awaitingPaymentRequests else {return 0}
            return awaitingPaymentArray.count
        case 2:
            guard let completedArray = completedRequests else {return 0}
            return completedArray.count
        default:
            print("How did you find another segment man?")
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? UserRequestTableViewCell
        
        switch selectedSegment {
        case 0:
            guard let pendingRequestArray = pendingAndInProgressRequests else {return UITableViewCell()}
            let request = pendingRequestArray[indexPath.row]
            cell?.request = request
        case 1:
            guard let awaitingPaymentArray = awaitingPaymentRequests else {return UITableViewCell()}
            let request = awaitingPaymentArray[indexPath.row]
            cell?.request = request
        case 2:
            guard let completedArray = completedRequests else {return UITableViewCell()}
            let request = completedArray[indexPath.row]
            cell?.request = request
        default:
            print("How did you find another segment man?")
            return UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
