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
    lazy var db = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    //Need to be able to create a user, have the user edit their profile, allow them to delete their profile
    
    //CRUD
    //CreateUser
    func CreateUser(userID: String, fullName: String, email: String, companyName: String, profileImage: UIImage, completion: @escaping (Bool) -> Void) {
        let user = User(userID: userID, fullName: fullName, email: email, company: companyName, profileImage: profileImage)
        let userDictionary = user.dictionaryRepresentation
        let profileImageStorageRef = storage.child("profileImages/\(user.userID)")
        let imageData = profileImage.jpegData(compressionQuality: 1)!
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uploadTask = profileImageStorageRef.putData(imageData, metadata: metadata)
        db.collection(FirestoreConstants.UserCollectionKey).document(user.userID).setData(userDictionary) { (error) in
            if let error = error {
                print(error)
                completion(true)
                return
            }
            self.currentUser = user
            completion(true)
        }
    }
    
    func fetchCurrentUserWith(userID: String, completion: @escaping (User?) -> Void) {
        let storageRef = Storage.storage().reference(withPath: "profileImages/\(userID)")
        storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("There was an error getting the profile image from storage!! : \(error.localizedDescription)")
                return
            }
            if let data = data {
                let image = UIImage(data: data)
                self.db.collection(FirestoreConstants.UserCollectionKey).document(userID).getDocument { (snapshot, error) in
                    if let error = error {
                        print("Could not fetch user \(userID): \(error.localizedDescription)")
                        return
                    }
                    guard let document = snapshot?.data(), let image = image else {return}
                    let user = User(document: document, profileImage: image)
                    completion(user)
                    return
                }

            }
        }
    }
}
