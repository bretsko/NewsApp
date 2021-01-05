//
//  LabelCell.swift
//  NewsApp
//
//  Created by Samuel Folledo on 4/7/20.
//  Copyright © 2020 Samuel Folledo. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    @IBOutlet private var lblTitle: UILabel!
    static var identifier = "LabelCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(title: String) {
        lblTitle.text = title
        layer.cornerRadius = 10
        layer.masksToBounds = true // same as clipsToBounds
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}
