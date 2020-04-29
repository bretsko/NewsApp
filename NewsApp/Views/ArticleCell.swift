//
//  NewsCell.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func populateViews(news: Article) {
        guard let title = news.title else { return }
        titleLabel.text = title
        guard let imgUrl = news.urlToImage else {
            imgView.isHidden = true
            return
        }
        
    }
}
