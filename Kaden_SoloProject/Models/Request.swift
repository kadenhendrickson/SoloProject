//
//  Request.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit



class Request {
    let usersFullName: String
    let userReference: String
    let timestamp: Date
    let address: String
    let status: Status
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
    
    init(usersFullName: String, userReference: String, timestamp: Date = Date(), address: String, status: Status = .pending , squareFootage: String, comments: String, userDateOne: Date, userDateTwo: Date, userDateThree: Date, chosenDate: Date?, photos: [UIImage] = [], videos: [Video] = [], photoPathIDs: [String] = [], videoPathIDs: [String] = [] ) {
        
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
        return [RequestConstants.userFullNameKey : usersFullName,
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
    
    convenience init?(firestore document: [String:Any]) {
        guard let usersFullName = document[RequestConstants.userFullNameKey] as? String,
            let userReference = document[RequestConstants.userReferenceKey] as? String,
            let address = document[RequestConstants.addressKey] as? String,
            let status = document[RequestConstants.statusKey] as? Status,
            let timestamp = document[RequestConstants.timestampKey] as? Date,
            let squareFootage = document[RequestConstants.squareFootageKey] as? String,
            let comments = document[RequestConstants.commentsKey] as? String,
            let userDateOne = document[RequestConstants.userDateOneKey] as? Date,
            let userDateTwo = document[RequestConstants.userDateTwoKey] as? Date,
            let userDateThree = document[RequestConstants.userDateThreeKey]as? Date,
            let chosenDate = document[RequestConstants.chosenDateKey] as? Date,
            let photoPathIDs = document[RequestConstants.photoPathIDKey] as? [String],
            let videoPathIDs = document[RequestConstants.videoPathIDKey] as? [String] else {return nil}
        
        self.init(usersFullName: usersFullName, userReference: userReference, timestamp: timestamp, address: address, status: status, squareFootage: squareFootage, comments: comments, userDateOne: userDateOne, userDateTwo: userDateTwo, userDateThree: userDateThree, chosenDate: chosenDate, photos: [], videos: [], photoPathIDs: photoPathIDs, videoPathIDs: videoPathIDs)
    }
}


