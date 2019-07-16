//
//  FetchUserViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/15/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit
import FirebaseAuth

class FetchUserViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handle = Auth.auth().addStateDidChangeListener({ (auth, fetchedUser) in
            print("Im doing the handle thing")
            if fetchedUser == nil {
                self.performSegue(withIdentifier: "toLoginVC", sender: nil)
                print("Fetched user was nil fam")
            } else {
                guard let userID = fetchedUser?.uid else {return}
                UserController.shared.fetchCurrentUserWith(userID: userID, completion: { (user) in
                    print("I fetched a user from firestore")
                    UserController.shared.currentUser = user
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabBar = storyboard.instantiateViewController(withIdentifier: "hostTabBar")
//                        let tabBar = storyboard.instantiateViewController(withIdentifier: "userTabBar")
                        UIApplication.shared.windows.first?.rootViewController = tabBar
                
                })
            }
        })

    }
}
