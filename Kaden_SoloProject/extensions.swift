//
//  extensions.swift
//  Kaden_SoloProject
//
//  Created by Kaden Hendrickson on 7/16/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation

extension Date {
    func toString(dateFormat: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateFormat
        dateFormatter.timeStyle = .short
        let myString = dateFormatter.string(from: self)
        let yourDate = dateFormatter.date(from: myString)
        dateFormatter.dateStyle = dateFormat
        
        return dateFormatter.string(from: yourDate!)
        
    }
}
