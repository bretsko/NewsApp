//
//  NewsListVC.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import Kingfisher

class NewsListVC: UIViewController, Storyboarded {
    
//MARK: Properties
    weak var coordinator: MainCoordinator?
    var articles: [Article] = [] {
       didSet {
           tableView.reloadData()
       }
    }
    var category: String! {
        didSet {
//            self.newsList = category.news
            self.title = "\(category!) News"
            fetchArticles()
        }
    }
    
//MARK: Views
    @IBOutlet weak var tableView: UITableView!
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

//MARK: Private Methods
    fileprivate func setupViews() {
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(NewsCell.self, forCellReuseIdentifier: String(describing: NewsCell.self)) //not needed if cell is created in storyboard
    }
    
//MARK: IBActions
    
    
//MARK: Helper Methods
    func fetchArticles() {
        NetworkManager.getArticles(endpoint: .category) { result in
            switch result {
            case let .success(articles):
                print("Articles are \(articles)")
//                self.articles = articles
            case let .failure(error):
                print(error)
            }
        }
    }
}

//MARK: Extensions
extension NewsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        coordinator?.goToNewsDetails(article: article)
    }
}

extension NewsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsCell.self), for: indexPath) as! NewsCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = "\(article.title)"
        return cell
    }
}
