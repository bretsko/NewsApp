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
    
    func populateViews(article: Article) {
        titleLabel.text = article.title
        sourceNameLabel.text = article.source.name
        let date = ISO8601DateFormatter().date(from: article.publishedAt!) //convert string to date
        publishedAtLabel.text = date?.stringValue //get the string value of the date
        imgView.image = UIImage()
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        mainIndicator.shouldAnimate(shouldAnimate: false)
        imgView.kf.setImage(with: article.urlToImage, placeholder: UIImage(),
                            progressBlock: { receivedSize, totalSize in
//                                print("Progress=\(receivedSize)/\(totalSize)")
                            },
                            completionHandler: { result in
                                self.imgIndicator.shouldAnimate(shouldAnimate: false)
                                do {
                                    let _ = try result.get() //value
                                } catch {
                                    DispatchQueue.main.async {
                                        self.imgView.isHidden = true
//                                    print("\(article.title!) has no image")
//                                    print("Article Image Error=", error.localizedDescription)
                                    }
                                }
                            })
    }
}
