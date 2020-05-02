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
        imgView.image = UIImage()
        mainIndicator.shouldAnimate(shouldAnimate: false)
        guard let title = article.title else { return }
        titleLabel.text = title
        imgView.kf.setImage(with: article.urlToImage, placeholder: UIImage(),
                            progressBlock: { receivedSize, totalSize in
//                                print("Progress=\(receivedSize)/\(totalSize)")
                            },
                            completionHandler: { result in
                                self.imgIndicator.shouldAnimate(shouldAnimate: false)
                                do {
                                    let _ = try result.get() //value
                                } catch {
                                    self.imgView.isHidden = true
//                                    print("\(article.title!) has no image")
//                                    print("Article Image Error=", error.localizedDescription)
                                }
                            })
    }
}
