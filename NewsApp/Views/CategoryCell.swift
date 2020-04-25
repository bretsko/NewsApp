//
//  CategoryCell.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var category: Category? {
        didSet {
            populateViews()
        }
    }
    
    func populateViews() {
        self.contentView.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        categoryLabel.text = category?.rawValue
    }
}
