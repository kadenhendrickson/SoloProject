//
//  UserRequestTableViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class UserRequestTableViewController: UITableViewController {
    
    var completedRequests: [Request] = []
    var awaitingPaymentRequests: [Request] = []
    var pendingAndInProgressRequests: [Request] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    
    var selectedSegment = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = UserController.shared.currentUser else {return}
        populateCompleteArray(currentUser)
        populateAwaitingPaymentArray(currentUser)
        populatePendingArray()
    }
    
    func populateAwaitingPaymentArray(_ currentUser: User) {
        RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.awaitingPaymentKey) { (requests) in
            self.awaitingPaymentRequests = requests
        }
    }
    
    func populateCompleteArray(_ currentUser: User) {
        RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.completeKey) { (requests) in
            self.completedRequests = requests
        }
    }
    
    @IBAction func segmentControllerSectionTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegment = 0
            tableView.reloadData()
        case 1:
            selectedSegment = 1
            tableView.reloadData()
        case 2:
            selectedSegment = 2
            tableView.reloadData()
        default:
            print("How did you find another section though?")
        }
    }
    
    //MARK: - Helper Functions
    func populatePendingArray() {
        guard let currentUser = UserController.shared.currentUser else {return}
        RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.pendingKey) { (requests) in
            self.pendingAndInProgressRequests = requests
        }
//        RequestController.shared.FetchRequestsWith(userID: currentUser.userID, requestStatus: StatusConstants.inProgressKey) { (requests) in
//            self.pendingAndInProgressRequests.append(contentsOf: requests)
//        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedSegment {
        case 0:
            return pendingAndInProgressRequests.count
        case 1:
            return awaitingPaymentRequests.count
        case 2:
            return completedRequests.count
        default:
            print("How did you find another segment man?")
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as? UserRequestTableViewCell
        
        switch selectedSegment {
        case 0:
            let request = pendingAndInProgressRequests[indexPath.row]
            cell?.request = request
        case 1:
            let request = awaitingPaymentRequests[indexPath.row]
            cell?.request = request
        case 2:
            let request = completedRequests[indexPath.row]
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRequestDV" {
            guard let desinationVC = segue.destination as? PendingRequestDetailViewController,
                let index = tableView.indexPathForSelectedRow else {return}
            var request: Request?
            switch selectedSegment {
            case 0:
                request = pendingAndInProgressRequests[index.row]
            case 1:
                request = awaitingPaymentRequests[index.row]
            case 2:
                request = completedRequests[index.row]
            default:
                print("Idk which segment you are on")
            }
            guard let requestToSend = request else {return}
            desinationVC.request = requestToSend
            
        }
    }
    

}

