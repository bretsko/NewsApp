//
//  ArticleListVC.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleListVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var sortTableView: UITableView!
    
    @IBOutlet weak var fromTableView: UITableView!
    @IBOutlet weak var toTableView: UITableView!
    
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    @IBOutlet weak var filterButtonsStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    enum TabBarType {
        case sort
        case from
        case to
    }
    
    /// currently opened tab bar option, if any
    var tabBarType: TabBarType?
    
    
    // MARK: -
    
    weak var coordinator: MainCoordinator?
    var articles: [Article] = [] {
        didSet {
            articlesTableView.reloadData()
        }
    }
    
    /// current news source
    var endpoint: EndPoint!
    
    /// currently displayed page
    private var page = 1
    
    
    // MARK: - App LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchArticles()
    }
    
    // MARK: - UI setup
    
    private func setupViews() {
        setupSearchBar()
        setupTableViews()
        switch endpoint {
        case .articles, .language:
            // show filter buttons for /everything endpoint
            filterButtonsStackView.isHidden = false
        default:
            filterButtonsStackView.isHidden = true
        }
    }
    
    private func setupTableViews() {
        
        func setup(_ tableView: UITableView, isHidden: Bool) {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            tableView.isHidden = isHidden
        }
        
        // DisplayOption buttons
        setup(sortTableView, isHidden: true)
        setup(fromTableView, isHidden: true)
        setup(toTableView, isHidden: true)
        
        // articlesTableView
        setup(articlesTableView, isHidden: false)
        articlesTableView.tableFooterView = UIView()
        articlesTableView.rowHeight = 100
        
        let nib = UINib(nibName: ArticleCell.identifier, bundle: .main)
        articlesTableView.register(nib, forCellReuseIdentifier: ArticleCell.identifier)
    }
    
    private func setupSearchBar() {
        
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Search for Articles"
        searchBar.returnKeyType = .search
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismissTap(_:)))
        toolBar.setItems([flexibleBar, doneButton], animated: true)
        searchBar.searchTextField.inputAccessoryView = toolBar
        searchBar.searchTextField.clearButtonMode = .always
    }
    
    // MARK: - IBActions
    
    @IBAction func filterButtonsTapped(_ sender: UIButton) {
        switch sender {
        case sortButton:
            if sortTableView.isHidden {
                showTableView(type: .sort)
            } else {
                showTableView(type: nil)
            }
            
        case fromButton:
            if fromTableView.isHidden {
                showTableView(type: .from)
            } else {
                showTableView(type: nil)
            }
            
        case toButton:
            if toTableView.isHidden {
                showTableView(type: .to)
            } else {
                showTableView(type: nil)
            }
        default:
            break
        }
    }
    
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) {
        // dismiss fields
        view.endEditing(false)
    }
    
    // MARK: -
    
    func fetchArticles() {
        activityIndicator.shouldAnimate()
        let params = ["page": "\(page)"]
        NetworkManager.shared.fetchNews(endpoint,
                                        parameters: params) { result in
            DispatchQueue.main.async { [weak self] in
                
                guard let weakSelf = self else {
                    return
                }
                switch result {
                case let .success(articles):
                    weakSelf.articles.append(contentsOf: articles)
                    weakSelf.activityIndicator.shouldAnimate(false)
                case let .failure(error):
                    weakSelf.presentAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    func updateParamsThenFetch(parameters: [String: String]) {
        NetworkManager.shared.update(parameters: parameters)
        page = 1 // reset page
        articles.removeAll()
        articlesTableView.reloadData()
        fetchArticles()
    }
    
    /// Hide all tables or show table depending on the UIButton selected
    /// if type is nil - hides all
    private func showTableView(type: TabBarType?) {
        
        tabBarType = type

        searchBar.resignFirstResponder()
        guard let type = type else {
            // hide everything
            UIView.animate(withDuration: 0.1) {
                self.allTableViews.forEach {
                    $0.isHidden = true
                }
            }
            return
        }
        UIView.animate(withDuration: 0.1) {
            switch type {
            case .sort:
                self.hideTableViews(except: self.sortTableView)
            case .from:
                self.hideTableViews(except: self.fromTableView)
            case .to:
                self.hideTableViews(except: self.toTableView)
            }
        }
    }
    
    private var allTableViews: [UITableView] {
        [toTableView, fromTableView, sortTableView]
    }
    
    private func hideTableViews(except tableView: UITableView) {
        allTableViews.forEach { tview in
            if tview != tableView {
                tview.isHidden = true
            } else {
                tview.isHidden = false
            }
        }
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate

extension ArticleListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let tabBarType = tabBarType else {
            // article list
            let article = articles[indexPath.row]
            coordinator?.goToNewsDetails(article: article)
            return
        }
        
        let parameters: [String : String]
        switch tabBarType {
        case .sort:
            let sortBy = SortByOptions.allCases[indexPath.row]
            
            sortButton.setTitle("Sort By: \(sortBy)",
                                for: .normal)
            parameters = ["sortBy": sortBy.paramString]
            
        case .from:
            // not include now case
            let fromDate = DateOptions.fromAllCases[indexPath.row]
            fromButton.setTitle("Past: \(fromDate.rawValue)",
                                for: .normal)
            parameters = ["from": fromDate.paramString]
            
        case .to:
            let toDate = DateOptions.allCases[indexPath.row]
            toButton.setTitle("Until: \(toDate.rawValue)",
                              for: .normal)
            parameters = ["to": toDate.paramString]
        }
        // hide all after press
        showTableView(type: nil)
        updateParamsThenFetch(parameters: parameters)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tabBarType == nil {
            return 100
        } else {
            //.sort, from, to
            return 30
        }
    }
}

// MARK: UITableViewDataSource

extension ArticleListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let tabBarType = tabBarType else {
            return articles.count
        }
        
        switch tabBarType {
        case .sort:
            return SortByOptions.allCases.count
        case .from:
            // ?
            // does not include now case
            return DateOptions.fromAllCases.count
        case .to:
            return DateOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tabBarType = tabBarType else {
            let articleCell = articlesTableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
            let article = articles[indexPath.row]
            articleCell.populateViews(with: article)
            
            // if last cell and it's not the last article, get more articles
            if indexPath.row == articles.count - 1,
               indexPath.row + 1 < NetworkManager.shared.numArticlesOnBackend {
                page += 1
                fetchArticles()
            }
            return articleCell
        }
        
        let cell: UITableViewCell
        switch tabBarType {
        case .sort:
            cell = sortTableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath)
            cell.textLabel?.text = SortByOptions.allCases[indexPath.row].rawValue
            cell.textLabel?.textAlignment = .center
            if indexPath.row == 1 {
                sortTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
            
        case .from:
            cell = fromTableView.dequeueReusableCell(withIdentifier: "fromCell", for: indexPath)
            cell.textLabel?.text = DateOptions.fromAllCases[indexPath.row].rawValue
            // not include now case
            cell.textLabel?.textAlignment = .center
            if indexPath.row == 2 {
                fromTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
            
        case .to:
            cell = toTableView.dequeueReusableCell(withIdentifier: "toCell", for: indexPath)
            cell.textLabel?.text = DateOptions.allCases[indexPath.row].rawValue
            cell.textLabel?.textAlignment = .center
            if indexPath.row == 0 {
                toTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
        }
        return cell
    }
}

// MARK: UISearchTextFieldDelegate

extension ArticleListVC: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let text = textField.text,
              !text.isEmpty else {
            return true
        }
        title = text
        sortButton.setTitle("Sort By: Relevancy", for: .normal)
        // change sort to relevancy as it will be closer to the textField input
        let indexPath = IndexPath(row: 2, section: 0)
        // relevancy's index
        articlesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        updateParamsThenFetch(parameters: ["q": text, "sortBy": SortByOptions.relevancy.paramString])
        return true
    }
}
