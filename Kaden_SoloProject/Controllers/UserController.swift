//
//  UserController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit
import Firebase

class UserController {
    
    static let shared = UserController()
    var currentUser: User?
    let db = Firestore.firestore()
    
    //Need to be able to create a user, have the user edit their profile, allow them to delete their profile
    
    //CRUD
    //CreateUser
    func CreateUser(fullName: String, email: String, companyName: String, profileImage: UIImage, completion: @escaping (Bool) -> Void) {
        let user = User(fullName: fullName, email: email, company: companyName, profileImage: profileImage)
        let userDictionary = user.dictionaryRepresentation
        db.collection(FirestoreConstants.UserCollectionKey).document(user.userID).setData(userDictionary)
        currentUser = user
        completion(true)
    }
    
}
