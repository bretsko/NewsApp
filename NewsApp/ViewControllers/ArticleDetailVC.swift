//
//  ArticleDetailVC.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!

    weak var coordinator: MainCoordinator?
    
    var article: Article! {
        didSet {
            title = article.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: -

    private func setupViews() {
        webView.navigationDelegate = self
        webView.load(URLRequest(url: article.url!))
        webView.allowsBackForwardNavigationGestures = true
    }
}
