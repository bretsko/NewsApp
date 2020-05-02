//
//  ArticleListVC.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleListVC: UIViewController, Storyboarded {
    
//MARK: Properties
    weak var coordinator: MainCoordinator?
    var articles: [Article] = [] {
       didSet {
           tableView.reloadData()
       }
    }
//    var parameters: [String: String] = [:] {
//        didSet {
//            self.title = parameters[kCATEGORY] ?? "News List"
//        }
//    }
    var page: Int = 0
    
//MARK: Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.shouldAnimate()
        getArticles()
    }

//MARK: Private Methods
    fileprivate func setupViews() {
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
//        tableView.register(NewsCell.self, forCellReuseIdentifier: String(describing: NewsCell.self)) //not needed if cell is created in storyboard
    }
    
//MARK: IBActions
    
    
//MARK: Helper Methods
    func getArticles() {
        NetworkManager.fetchNewsApi(endpoint: .category) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(articles):
                    print("New articles = \(articles.count)")
                    self.articles.append(contentsOf: articles)
                    self.activityIndicator.shouldAnimate(shouldAnimate: false)
                case let .failure(error):
                    Service.presentAlert(on: self, title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}

//MARK: Extensions
extension ArticleListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        coordinator?.goToNewsDetails(article: article)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ArticleListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self), for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        cell.populateViews(article: article)
        if indexPath.row == articles.count - 1 { //if last cell, get more articles
            self.page += 1 //increment page
            getArticles()
        }
        return cell
    }
}
