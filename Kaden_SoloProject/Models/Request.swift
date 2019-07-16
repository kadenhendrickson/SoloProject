//
//  Request.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit
import Firebase

class Request {
    let projectName: String?
    let requestID: String
    let usersFullName: String
    let userReference: String
    let timestamp: Date
    let address: String
    let status: String
    let squareFootage: String
    let comments: String
    let userDateOne: Date
    let userDateTwo: Date
    let userDateThree: Date
    var chosenDate: Date?
    let photos: [UIImage]
    let videos: [Video]
    let photoPathIDs: [String]
    let videoPathIDs: [String]
    
    init(projectName: String?, requestID: String = UUID().uuidString, usersFullName: String = UserController.shared.currentUser!.fullName, userReference: String = UserController.shared.currentUser!.userID, timestamp: Date = Date(), address: String, status: String = StatusConstants.pendingKey, squareFootage: String, comments: String, userDateOne: Date, userDateTwo: Date, userDateThree: Date, chosenDate: Date?, photos: [UIImage] = [], videos: [Video] = [], photoPathIDs: [String] = [], videoPathIDs: [String] = [] ) {
        
        self.projectName = projectName
        self.requestID = requestID
        self.usersFullName = usersFullName
        self.userReference = userReference
        self.timestamp = timestamp
        self.address = address
        self.status = status
        self.squareFootage = squareFootage
        self.comments = comments
        self.userDateOne = userDateOne
        self.userDateTwo = userDateTwo
        self.userDateThree = userDateThree
        self.chosenDate = chosenDate
        self.photos = photos
        self.videos = videos
        self.photoPathIDs = photoPathIDs
        self.videoPathIDs = videoPathIDs
    }
    
    var dictionaryRepresentation: [String:Any] {
        return [RequestConstants.projectNameKey : projectName ?? "My project",
                RequestConstants.requestIDKey : requestID,
                RequestConstants.userFullNameKey : usersFullName,
                RequestConstants.userReferenceKey : userReference,
                RequestConstants.timestampKey : timestamp,
                RequestConstants.addressKey : address,
                RequestConstants.statusKey : status,
                RequestConstants.squareFootageKey : squareFootage,
                RequestConstants.commentsKey : comments,
                RequestConstants.userDateOneKey : userDateOne,
                RequestConstants.userDateTwoKey : userDateTwo,
                RequestConstants.userDateThreeKey : userDateThree,
                RequestConstants.chosenDateKey : chosenDate ?? userDateOne,
                RequestConstants.photoPathIDKey : photoPathIDs,
                RequestConstants.videoPathIDKey : videoPathIDs]
    }
    
    convenience init?(document: [String:Any]) {
        guard let projectName = document[RequestConstants.projectNameKey] as? String,
            let requestID = document[RequestConstants.requestIDKey] as? String,
            let usersFullName = document[RequestConstants.userFullNameKey] as? String,
            let userReference = document[RequestConstants.userReferenceKey] as? String,
            let address = document[RequestConstants.addressKey] as? String,
            let status = document[RequestConstants.statusKey] as? String,
            let timestampAsTimestamp = document[RequestConstants.timestampKey] as? Timestamp,
            let squareFootage = document[RequestConstants.squareFootageKey] as? String,
            let comments = document[RequestConstants.commentsKey] as? String,
            let userDateOneAsTimestamp = document[RequestConstants.userDateOneKey] as? Timestamp,
            let userDateTwoAsTimestamp = document[RequestConstants.userDateTwoKey] as? Timestamp,
            let userDateThreeAsTimestamp = document[RequestConstants.userDateThreeKey]as? Timestamp,
            let chosenDateAsTimestamp = document[RequestConstants.chosenDateKey] as? Timestamp,
            let photoPathIDs = document[RequestConstants.photoPathIDKey] as? [String],
            let videoPathIDs = document[RequestConstants.videoPathIDKey] as? [String] else {return nil}
        
        let timestamp = timestampAsTimestamp.dateValue()
        let userDateOne = userDateOneAsTimestamp.dateValue()
        let userDateTwo = userDateTwoAsTimestamp.dateValue()
        let userDateThree = userDateThreeAsTimestamp.dateValue()
        let chosenDate = chosenDateAsTimestamp.dateValue()
        
        self.init(projectName: projectName, requestID: requestID, usersFullName: usersFullName, userReference: userReference, timestamp: timestamp, address: address, status: status, squareFootage: squareFootage, comments: comments, userDateOne: userDateOne, userDateTwo: userDateTwo, userDateThree: userDateThree, chosenDate: chosenDate, photos: [], videos: [], photoPathIDs: photoPathIDs, videoPathIDs: videoPathIDs)
    }
}


