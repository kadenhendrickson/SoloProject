//
//  UploadMediaViewController.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class UploadMediaViewController: UIViewController {
    
    var request: Request?
    
    var photosArray: [UIImage] = []
    var videosArray: [Video] = []
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectAddressLabel: UILabel!
    @IBOutlet weak var projectClientNameLabel: UILabel!
    @IBOutlet weak var projectStatusLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var uploadMediaButton: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        photoCollectionView.delegate = self
        videoCollectionView.delegate = self
        
        photoCollectionView.dataSource = self
        videoCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let request = request else {return}
        projectNameLabel.text = request.projectName
        projectAddressLabel.text = request.address
        projectClientNameLabel.text = request.usersFullName
        projectStatusLabel.text = request.status
        selectedDateLabel.text = request.chosenDate?.toString(dateFormat: .long)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UploadMediaViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollectionView {
            return photosArray.count + 1
        }
        else if collectionView == videoCollectionView {
            return videosArray.count + 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoCollectionView {
            guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else {return UICollectionViewCell()}
            if photoCell.tag == 0 {
                photoCell.backgroundColor = .red
                
            } else {
                let image = photosArray[indexPath.row]
                photoCell.image = image
            }
            
            
            
            return photoCell
        }
        else if collectionView == videoCollectionView {
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath)
            videoCell.backgroundColor = .blue
            return videoCell
        }
        return UICollectionViewCell()
    }
    
    
    
    
    
}
