//
//  NewsListVC.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class NewsListVC: UIViewController, Storyboarded {
    
//MARK: Properties
    weak var coordinator: MainCoordinator?
    var newsList: [News] = []
    
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
        self.title = "News List"
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: String(describing: NewsCell.self))
    }
    
//MARK: IBActions
    
    
//MARK: Helper Methods

}

//MARK: Extensions
extension NewsListVC: UITableViewDelegate {
    
}

extension NewsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsCell.self), for: indexPath) as! NewsCell
        let news = newsList[indexPath.row]
        cell.titleLabel.text = "\(news.title)"
        return cell
    }
}
