//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/24/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mainIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imgIndicator: UIActivityIndicatorView!
    
    
    //MARK: -
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainIndicator.shouldAnimate()
        imgIndicator.shouldAnimate()
        titleLabel.text = ""
        sourceNameLabel.text = ""
        publishedAtLabel.text = ""
        imgView.image = UIImage()
        imgView.kf.cancelDownloadTask()
    }
    
    func populateViews(with article: Article) {
        
        titleLabel.text = article.title
        sourceNameLabel.text = article.source.name
        let date = ISO8601DateFormatter().date(from: article.publishedAt!)
        publishedAtLabel.text = date?.stringValue
        imgView.image = UIImage()
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        mainIndicator.shouldAnimate(false)
        
        imgView.kf.setImage(with: article.urlToImage, placeholder: UIImage(),
        completionHandler: { result in
            DispatchQueue.main.async { [weak self] in
                
                self?.imgIndicator.shouldAnimate(false)
                do {
                    _ = try result.get() // value
                } catch {
                    
                    self?.imgView.isHidden = true
                    //                                    print("\(article.title!) has no image")
                    //                                    print("Article Image Error=", error.localizedDescription)
                }
            }
        })
        
    }
}
