//
//  ImageCell.swift
//  NewsApp
//
//  Created by Samuel Folledo on 4/7/20.
//  Copyright © 2020 Samuel Folledo. All rights reserved.
//

import UIKit
//import Kingfisher

class ImageCell: UICollectionViewCell {
    
    static var identifier: String = "ImageCell"
    
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContents(title: String, image: UIImage = UIImage()) {
        coverImg.image = image
        titleLabel.text = title
    }
    
    override func prepareForReuse() {
//        coverImg.kf.cancelDownloadTask()
        coverImg.image = nil
        titleLabel.text = nil
    }
}
