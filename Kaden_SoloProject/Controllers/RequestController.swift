//
//  RequestController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/9/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit
import Firebase

class RequestController {
    //MARK: - Properties
    static let shared = RequestController()
    lazy var db = Firestore.firestore()
    var requestListener: ListenerRegistration?
    
    
    //Push a document to firestore that has all of the request properties except the photos and videos array.
    //the first time the request document is pushed both the PATHID arrays will be empty
    
    //I will need to pull down the request model, update the state of "Status", send my photos and video to Google storage, update the arrays with the photo and video PathID's, then update the pathID arrays.
    
    //when complete, the user will need to pull down that document with the PATHID arrays filled....Then perform
    //the "get photos and videos" crap on google storage.
    
    
    //CRUD FUNCTIONS
    
    //USERCRUDS
    //UserCreateRequest
    func UserCreateRequest(projectName: String?, address: String, squareFootage: String, comments: String = "", userDateOne: Date, userDateTwo: Date, userDateThree: Date) {
        let request = Request(projectName: projectName ?? "My Project", address: address, squareFootage: squareFootage, comments: comments, userDateOne: userDateOne, userDateTwo: userDateTwo, userDateThree: userDateThree, chosenDate: nil)
        let requestDictionary = request.dictionaryRepresentation
        db.collection(FirestoreConstants.RequestCollectionKey).document(request.requestID).setData(requestDictionary)
    }
    //UserCancelRequest
    func UserCancelRequest(requestID: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    //FetchRequest for specific user based on status (filter fetch by status and sort by timestamp)
    func FetchRequestsWith(userID: String, requestStatus: String, completion: @escaping ([Request]) -> Void) {
        let requestReference = db.collection(FirestoreConstants.RequestCollectionKey)
        var requestsArray: [Request] = []
        requestReference.whereField(RequestConstants.statusKey, isEqualTo: requestStatus).whereField(RequestConstants.userReferenceKey, isEqualTo: userID).order(by: "timestamp").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("🤪🤪There was an error fetching your requests!!🤪🤪 :\(error.localizedDescription)")
            }
            guard let documents = snapshot?.documents else {return}
            requestsArray.removeAll()
            for document in documents {
                let dataDictionary = document.data()
                guard let request = Request(document: dataDictionary) else {print("I am failing to create a request object");return}
                requestsArray.append(request)
            }
            print("This is FETCHREQUESTWITHUSERID confirming thatt we have an array of requests!!")
            completion(requestsArray)
            return
        }
    }
    //User download photos from cloudstorage
    func fetchImagesWith(requestID: String, arrayOfPathIDs: [String], completion: @escaping ([UIImage]) -> Void) {
        var imagesArray: [UIImage] = []
        for pathID in arrayOfPathIDs {
            let storageRef = Storage.storage().reference(withPath: "\(requestID)/images/\(pathID)")
            let downloadTask = storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                if let error = error {
                    print("🤪🤪There was an error downloading the images!🤪🤪 :\(error.localizedDescription)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    imagesArray.append(image)
                }
            }
        }
        completion(imagesArray)
        return
    }
    
    //User download videos from cloudstorage
    func fetchVideosWith(requestID: String, downloadUrlStrings: [String], completion: @escaping ([Video]) -> Void) {
        var videosArray: [Video] = []
        for urlString in downloadUrlStrings{
            guard let url = URL(string: urlString) else {return}
            let video = Video(url: url)
            videosArray.append(video)
        }
        completion(videosArray)
        
//        for pathID in arrayOfPathIDs {
//            let storageRef = Storage.storage().reference(withPath: "\(requestID)/videos/\(pathID)")
//            let downloadTask = storageRef.downloadURL { (url, error) in
//                if let error = error {
//                    print("🤪🤪There was an error fetching the download URL🤪🤪: \(error.localizedDescription)")
//                    return
//                }
//                if let url = url {
//                    let video = Video(url: url)
//                    videosArray.append(video)
//                }
//            }
//        }
//        completion(videosArray)
//        return
    }
    
    //HOSTCRUDS
    //HostUpdateRequestStatus
    func updateRequestStatusAndDateWith(requestID: String, chosenDate: Date, status: String) {
        let requestRef = db.collection(FirestoreConstants.RequestCollectionKey).document(requestID)
        requestRef.updateData(["status" : status])
        requestRef.updateData([RequestConstants.chosenDateKey : chosenDate])
    }
    //HostUpdateRequestPathID's
    func updateRequestPathIDsWith(requestID: String, photoPathIDs: [String], videoPathIDs: [String]) {
        let requestRef = db.collection(FirestoreConstants.RequestCollectionKey).document(requestID)
        requestRef.updateData(["photoPathID" : FieldValue.arrayUnion(photoPathIDs),
                               "videoPathID" : FieldValue.arrayUnion(videoPathIDs)])
    }
    //FetchRequest for all requests (filter by status and sort by timestamp)
    func fetchRequestsWith(status: String, completion: @escaping ([Request]) -> Void) {
        var requestsArray: [Request] = []
        let requestsRef = db.collection(FirestoreConstants.RequestCollectionKey)
        requestsRef.whereField(RequestConstants.statusKey, isEqualTo: status).order(by: "timestamp").addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("🤪🤪There was an error fetching the users requests!!🤪🤪 : \(error.localizedDescription)")
                return
            }
            requestsArray.removeAll()
            guard let documents = snapshot?.documents else {return}
            for document in documents {
                let dataDictionary = document.data()
                if let request = Request(document: dataDictionary) {
                    requestsArray.append(request)
                }
            }
            completion(requestsArray)
            return
        }
    }
    //Host push photos to cloud storage
    func uploadImagesToCloudStorageWith(requestID: String, images: [UIImage], downloadUrls completion: @escaping ([String]) -> Void) {
        var imageDataArray: [Data] = []
        var pathIDs: [String] = [] //Not currently using because i think i can return download urls
        var downloadUrls: [String] = []
        for image in images {
            if let imageData = image.jpegData(compressionQuality: 1){
                imageDataArray.append(imageData)
            }
        }
        for imageData in imageDataArray {
            let randomID = UUID().uuidString
            pathIDs.append(randomID) // not using because of download urls
            let imagesStorageRef = Storage.storage().reference(withPath: "\(requestID)/images/\(randomID)")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let uploadTask = imagesStorageRef.putData(imageData, metadata: metadata)
            imagesStorageRef.downloadURL { (url, error) in
                guard let downloadUrl = url else {print("There was an error getting the download url for these images!"); return}
                downloadUrls.append("\(downloadUrl)")
            }
            
        }
        completion(downloadUrls)
        return
    }
    //Host push videos to cloud storage
    func uploadVideosToCloudStorage(requestID: String, videoFilePaths: [String], downloadUrls completion: @escaping ([String]) -> Void) {
        var localFiles: [URL] = []
        var pathIDs: [String] = [] // Not using because i'm completing with download urls instead
        var downloadUrls: [String] = []
        for filePath in videoFilePaths {
            guard let localFile = URL(string: filePath) else {return}
            localFiles.append(localFile)
        }
        for localFile in localFiles {
            let randomID = UUID().uuidString
            pathIDs.append(randomID) // not using because of download urls
            let videosStorageRef = Storage.storage().reference(withPath: "\(requestID)/videos/\(randomID)")
            let metadata = StorageMetadata()
            metadata.contentType = "movie/mp4"
            videosStorageRef.putFile(from: localFile, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("There was an error storing the files!! : \(error.localizedDescription)")
                    return
                }
                videosStorageRef.downloadURL(completion: { (url, error) in
                    if let error = error {
                      print("There was an error getting a download URL for your video!: \(error.localizedDescription)")
                    }
                    guard let downloadUrl = url else {return}
                    downloadUrls.append("\(downloadUrl)")
                })
            }
        }
        completion(downloadUrls)
        return
    }
}
