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
    var articles: [Article] = []
    
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
        fetchArticles(page: page)
    }
    
    // MARK: - UI setup
    
    private func setupViews() {
        setupSearchBar()
        setupTableViews()
        
        // filters currently only work in everything endpoint
//        switch endpoint {
//        case .articles, .language:
//            filterButtonsStackView.isHidden = false
//        default:
//            filterButtonsStackView.isHidden = true
//        }
    }
    var filterButtons: [UIButton] {
        [sortButton, toButton, fromButton]
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
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        if sortTableView.isHidden {
            showFilterTableView(type: .sort)
        } else {
            showFilterTableView(type: nil)
        }
    }
    
    @IBAction func fromButtonTapped(_ sender: UIButton) {
        if fromTableView.isHidden {
            showFilterTableView(type: .from)
        } else {
            showFilterTableView(type: nil)
        }
    }
    
    @IBAction func toButtonTapped(_ sender: UIButton) {
        if toTableView.isHidden {
            showFilterTableView(type: .to)
        } else {
            showFilterTableView(type: nil)
        }
    }
    
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) {
        // dismiss fields
        view.endEditing(false)
    }
    
    // MARK: -
    
    private func fetchArticles(page: Int) {
        
        let qitems = NetworkManager.makeURLQueryItems(page: page)
        
        activityIndicator.shouldAnimate()
        NetworkManager.shared.fetchArticles(endpoint,
                                            pageParams: qitems) { result in
            DispatchQueue.main.async { [weak self] in
                
                guard let weakSelf = self else {
                    return
                }
                switch result {
                case let .success(articles):
                    weakSelf.articles += articles
                    weakSelf.activityIndicator.shouldAnimate(false)
                    weakSelf.articlesTableView.reloadData()
                case let .failure(error):
                    weakSelf.presentAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    
    /// Hide all tables or show table depending on the UIButton selected
    /// if type is nil - hides all
    private func showFilterTableView(type: TabBarType?) {
        
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
        
        //TODO: setup filters
//        let titleStr = titleForFilterButton(with: tabBarType,
//                                            at: indexPath.row)
//        let param = filterParam(for: tabBarType,
//                                at: indexPath.row)
//        //endpoint = .source(Set([param]))
//
//        switch tabBarType {
//        case .sort:
//            sortButton.setTitle(titleStr, for: .normal)
//        case .from:
//            fromButton.setTitle(titleStr, for: .normal)
//        case .to:
//            toButton.setTitle(titleStr, for: .normal)
//        }
//        // hide all after press
//        showFilterTableView(type: nil)
//
//        page = 1 // reset page
//        fetchArticles(page: page)
    }
    
    func filterParam(for tabBarType: TabBarType,
                     at row: Int) -> FilterOption {
        switch tabBarType {
        case .sort:
            let sortByOptions = SortByOptions.allCases[row]
            return .sortBy(sortByOptions)
            
        case .from:
            // not include now case
            let fromDate = DateOptions.fromAllCases[row]
            return .fromDate(fromDate)
            
        case .to:
            let toDate = DateOptions.allCases[row]
            return .toDate(toDate)
        }
    }
    
    func titleForFilterButton(with tabBarType: TabBarType,
                              at row: Int) -> String {
        switch tabBarType {
        case .sort:
            let sortBy = SortByOptions.allCases[row]
            return "Sort By: \(sortBy)"
            
        case .from:
            // not include now case
            let fromDate = DateOptions.fromAllCases[row]
            return "Past: \(fromDate.rawValue)"
            
        case .to:
            let toDate = DateOptions.allCases[row]
            return "Until: \(toDate.rawValue)"
        }
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
               indexPath.row < NetworkManager.shared.numArticlesOnBackend {
                page += 1
                fetchArticles(page: page)
            }
            return articleCell
        }
        
        let cell: UITableViewCell
        switch tabBarType {
        case .sort:
            cell = sortTableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath)
            
            let option = SortByOptions.allCases[indexPath.row]
            switch option {
            case .publishedAt:
                cell.textLabel?.text = "Newest"
            case .relevancy:
                cell.textLabel?.text = "Relevancy"
            case .popularity:
                cell.textLabel?.text = "Popularity"
            }
            
            cell.textLabel?.textAlignment = .center
            if indexPath.row == 1 {
                sortTableView.selectRow(at: indexPath,
                                        animated: true,
                                        scrollPosition: .middle)
            }
            
        case .from:
            cell = fromTableView.dequeueReusableCell(withIdentifier: "fromCell", for: indexPath)
            cell.textLabel?.text = DateOptions.fromAllCases[indexPath.row].rawValue
            // not include now case
            cell.textLabel?.textAlignment = .center
            if indexPath.row == 2 {
                fromTableView.selectRow(at: indexPath,
                                        animated: true,
                                        scrollPosition: .middle)
            }
            
        case .to:
            cell = toTableView.dequeueReusableCell(withIdentifier: "toCell", for: indexPath)
            cell.textLabel?.text = DateOptions.allCases[indexPath.row].rawValue
            cell.textLabel?.textAlignment = .center
            if indexPath.row == 0 {
                toTableView.selectRow(at: indexPath,
                                      animated: true,
                                      scrollPosition: .middle)
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
        
        //???
        sortButton.setTitle("Sort By: Relevancy", for: .normal)
        // change sort to relevancy as it will be closer to the textField input
        
        let indexPath = IndexPath(row: 2, section: 0)
        // relevancy's index
        articlesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        
        let filterOption1 = FilterOption.query(text)
        let filterOption2 = FilterOption.sortBy(.relevancy)
        
        endpoint = .search(Set([filterOption1, filterOption2]))
        
        page = 1 // reset page
        fetchArticles(page: page)
        return true
    }
}
