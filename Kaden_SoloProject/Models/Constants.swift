//
//  Constants.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation

struct UserConstants {
    static let userIDKey = "userID"
    static let fullNameKey = "fullName"
    static let emailKey = "email"
    static let companyKey = "company"
    static let profileImageKey = "profileImage"
}

struct RequestConstants {
    static let projectNameKey = "projectName"
    static let requestIDKey = "requestID"
    static let userFullNameKey = "usersFullName"
    static let userReferenceKey = "userReference"
    static let timestampKey = "timestamp"
    static let addressKey = "address"
    static let statusKey = "status"
    static let squareFootageKey = "squareFootage"
    static let commentsKey = "comments"
    static let userDateOneKey = "userDateOne"
    static let userDateTwoKey = "userDateTwo"
    static let userDateThreeKey = "userDateThree"
    static let chosenDateKey = "chosenDate"
    static let photosKey = "photos"
    static let videosKey = "videos"
    static let photoPathIDKey = "photoPathID"
    static let videoPathIDKey = "videoPathID"
}

struct StatusConstants {
    static let pendingKey = "Pending"
    static let inProgressKey = "In Prgoress"
    static let awaitingPaymentKey = "Awaiting Payment"
    static let completeKey = "Complete"
}

struct FirestoreConstants {
    static let RequestCollectionKey = "Requests"
    static let UserCollectionKey = "Users"
}
