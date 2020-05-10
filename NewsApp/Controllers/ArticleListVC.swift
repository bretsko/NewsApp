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
    var sortOptions: [String] = ["Newest", "Popularity", "Relevancy"]
    var dateOptions: [String] = ["Today", "1 week", "2 weeks", "1 month", "3 months"]
    var endpoint: EndPoints!
    var page: Int = 1
    
//MARK: Views
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var sortTable: UITableView!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var fromTable: UITableView!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var toTable: UITableView!
    
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
        sortTable.delegate = self
        sortTable.dataSource = self
        sortTable.isHidden = true
        fromTable.delegate = self
        fromTable.dataSource = self
        fromTable.isHidden = true
        toTable.delegate = self
        toTable.dataSource = self
        toTable.isHidden = true
//        tableView.register(NewsCell.self, forCellReuseIdentifier: String(describing: NewsCell.self)) //not needed if cell is created in storyboard
    }
    
    func getArticles() {
        NetworkManager.fetchNewsApi(endpoint: endpoint, parameters: [kPAGE: "\(page)"]) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(articles):
                    self.articles.append(contentsOf: articles)
                    self.activityIndicator.shouldAnimate(shouldAnimate: false)
                case let .failure(error):
                    Service.presentAlert(on: self, title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
//MARK: IBActions
    @IBAction func filterButtonsTapped(_ sender: UIButton) {
        switch sender {
        case sortButton:
            toggleButtonTables(shouldShow: sortTable.isHidden, type: sortButton)
        case fromButton:
            toggleButtonTables(shouldShow: fromTable.isHidden, type: fromButton)
        case toButton:
            toggleButtonTables(shouldShow: toTable.isHidden, type: toButton)
        default:
            break
        }
    }
    
    
//MARK: Helper Methods
    func getArticles() {
        NetworkManager.fetchNewsApi(endpoint: endpoint, parameters: [kPAGE: "\(page)"]) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(articles):
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
        switch tableView {
        case self.tableView: //article list
            let article = articles[indexPath.row]
            coordinator?.goToNewsDetails(article: article)
        case sortTable:
            let sortyBy = sortOptions[indexPath.row]
        case fromTable:
            let fromDate = dateOptions[indexPath.row]
        case toTable:
            let toDate = dateOptions[indexPath.row]
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case self.tableView: //article list
            return 100
        case sortTable, fromTable, toTable:
            return 30
        default:
            return 0
        }
    }
}

extension ArticleListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.tableView: //article list
            return articles.count
        case sortTable:
            return sortOptions.count
        case fromTable, toTable:
            return dateOptions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.tableView: //article list
            let cell: ArticleCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self), for: indexPath) as! ArticleCell
            let article = articles[indexPath.row]
            cell.populateViews(article: article)
            if indexPath.row == articles.count - 1 && indexPath.row < NetworkManager.totalCount - 1 { //if last cell and it's not the last article, get more articles
                self.page += 1 //increment page
                getArticles()
            }
            return cell
        case sortTable:
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath)
            cell.textLabel?.text = sortOptions[indexPath.row]
            return cell
        case fromTable:
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "fromCell", for: indexPath)
            cell.textLabel?.text = dateOptions[indexPath.row]
            return cell
        case toTable:
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "toCell", for: indexPath)
            cell.textLabel?.text = dateOptions[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
}
