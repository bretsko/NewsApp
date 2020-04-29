//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mainIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainIndicator.shouldAnimate()
        imgIndicator.shouldAnimate()
        titleLabel.text = ""
        imgView.image = UIImage()
    }
    
    func populateViews(article: Article) {
        mainIndicator.shouldAnimate(shouldAnimate: false)
        guard let title = article.title else { return }
        titleLabel.text = title
        guard let imgUrl = article.urlToImage else {
            imgIndicator.shouldAnimate(shouldAnimate: false)
            imgView.isHidden = true
            return
        }
    }
}
