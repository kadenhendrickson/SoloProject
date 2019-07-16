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
        self.profileImage  = profileImage.jpegData(compressionQuality: 0.5)!
    }
    
    var dictionaryRepresentation: [String:Any] {
        return [UserConstants.userIDKey : userID,
                UserConstants.fullNameKey : fullName,
                UserConstants.emailKey : email,
                UserConstants.companyKey : company]
    }
    
    convenience init?(document: [String:Any], profileImage: UIImage) {
        guard let userID = document[UserConstants.userIDKey] as? String,
                let fullName = document[UserConstants.fullNameKey] as? String,
                let email = document[UserConstants.emailKey] as? String,
                let company = document[UserConstants.companyKey] as? String else {return nil}
        self.init(userID: userID, fullName: fullName, email: email, company: company, profileImage: profileImage)
        
    }
}
