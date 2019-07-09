//
//  User.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit



class User {
    let userID: String
    let fullName: String
    let email: String
    let company: String
    let profileImage: Data
    
    init(userID: String, fullName: String, email: String, company: String, profileImage: UIImage) {
        self.userID = userID
        self.fullName = fullName
        self.email = email
        self.company = company
        self.profileImage  = profileImage.jpegData(compressionQuality: 0.15)!
    }
    
    var dictionaryRepresentation: [String:Any] {
        return [UserConstants.userIDKey : userID,
                UserConstants.fullNameKey : fullName,
                UserConstants.emailKey : email,
                UserConstants.companyKey : company,
                UserConstants.profileImageKey : profileImage]
    }
}
