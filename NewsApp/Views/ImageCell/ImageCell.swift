//
//  ImageCell.swift
//  NewsApp
//
//  Created by Samuel Folledo on 4/7/20.
//  Copyright © 2020 Samuel Folledo. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ImageCell"
    let gradientLayer = CAGradientLayer()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setContents(title: String, image: UIImage = UIImage()) {
        titleLabel.text = title
        coverImg.image = image
        coverImg.layer.cornerRadius = 10
        coverImg.layer.masksToBounds = true // same as clipsToBounds
        darkenImageView()
    }
    
    override func prepareForReuse() {
        coverImg.image = nil
        titleLabel.text = nil
        gradientLayer.colors = [UIColor.clear.cgColor] // reset the color
    }
    
    private func darkenImageView() {
        guard let black: CGColor = UIColor.black.cgColor.copy(alpha: 0.7) else { return }
        gradientLayer.colors = [UIColor.clear.cgColor, black]
        gradientLayer.locations = [0, 0.4] // 0.75 instead of 0 so there will be more clear color than black
        gradientLayer.frame = coverImg.frame
        coverImg.layer.addSublayer(gradientLayer)
    }
}
