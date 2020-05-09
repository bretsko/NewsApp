//
//  LabelCell.swift
//  NewsApp
//
//  Created by Samuel Folledo on 4/7/20.
//  Copyright © 2020 Samuel Folledo. All rights reserved.
//

import UIKit


class LabelCell: UICollectionViewCell {
    
    static var identifier: String = "LabelCell"
    @IBOutlet private var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(title: String) {
        lblTitle.text = title
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true //same as clipsToBounds
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
