//
//  PhotoCollectionViewCell.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet {
            updateWithImage()
        }
    }
    
    @IBOutlet weak var photoCellImageView: UIImageView!
    
    
    func updateWithImage() {
        photoCellImageView.image = image
    }
    
    
}
