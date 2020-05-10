//
//  HomeVC.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, Storyboarded {
    
//MARK: Properties
    weak var coordinator: MainCoordinator?
    lazy var sections: [Section] = [
        TitleSection(title: "Categories"),
        ImageSection(categories: Category.allCases),
        TitleSection(title: "Countries"),
        LabelSection(titles: Country.allCases.map { $0.rawValue }), //since titles is an array of String, we need to map allCases to its rawValue
        TitleSection(title: "Languages"),
        LabelSection(titles: Language.allCases.map { $0.rawValue }),
        TitleSection(title: "Sources"),
        LabelSection(titles: []) //keep it empty for now as we fetch sources
    ]
    lazy var collectionViewLayout: UICollectionViewLayout = {
        var sections = self.sections
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return sections[sectionIndex].layoutSection()
        }
        return layout
    }()
    var sources: [Source] = [] {
        didSet {
            sections[7] = LabelSection(titles: sources.map{ $0.name } ) //create an array of sources name from sources
            collectionView.reloadData()
        }
    }
    
//MARK: Views
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.resetNetworkManager()
    }

//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "News Stand"
        setupCollectionView()
        setupSearchBar()
        fetchSources()
    }
    
    ///fetches a list of sources which is needed to fetch articles by language and by source
    fileprivate func fetchSources() {
        NetworkManager.fetchSources { (result) in
            switch result {
            case let .success(sources):
                self.sources.append(contentsOf: sources)
            case let .failure(error):
                Service.presentAlert(on: self, title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    fileprivate func setupSearchBar() {
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Search for News"
        searchBar.returnKeyType = .search
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.handleDismissTap(_:)))
        toolBar.setItems([flexibleBar, doneButton], animated: true)
        searchBar.searchTextField.inputAccessoryView = toolBar
        searchBar.searchTextField.clearButtonMode = .always
    }
    
    fileprivate func setupCollectionView() {
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self)) //no need since it's inside collectionView's story
        collectionView.register(UINib(nibName: TitleCell.identifier, bundle: .main), forCellWithReuseIdentifier: TitleCell.identifier)
        collectionView.register(UINib(nibName: ImageCell.identifier, bundle: .main), forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.register(UINib(nibName: LabelCell.identifier, bundle: .main), forCellWithReuseIdentifier: LabelCell.identifier)
    }
    
//MARK: IBActions
    
    
//MARK: Helper Methods
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) { //dismiss fields
        self.view.endEditing(false)
    }
}

//MARK: Extensions

//MARK: CollectionView Delegate Extension
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1: //fetch articles by categories
            let section = sections[indexPath.section] as! ImageSection
            let category = section.categories[indexPath.row]
            let vcTitle = Category.allCases[indexPath.row].rawValue + " News"
            coordinator?.goToNewsList(endpoint: .category, vcTitle: vcTitle, parameters: [kCATEGORY: category.rawValue])
        case 3: //fetch articles by countries
            let country = String(describing: Country.allCases[indexPath.row]) //convert enum case to string
            let vcTitle = Country.allCases[indexPath.row].rawValue + " News"
            coordinator?.goToNewsList(endpoint: .country, vcTitle: vcTitle, parameters: [kCOUNTRY: country])
        case 5: //fetch articles by language
            let language = String(describing: Language.allCases[indexPath.row])
            let vcTitle = Language.allCases[indexPath.row].rawValue + " News"
            let sourcesQueryString = Language.getSourcesString(language: language, sources: self.sources) //fetching articles by language requires sources query
            coordinator?.goToNewsList(endpoint: .language, vcTitle: vcTitle, parameters: [kLANGUAGE: language, kSOURCES: sourcesQueryString])
        case 7: //fetch articles by source
            let source = sources[indexPath.row]
            coordinator?.goToNewsList(endpoint: .source, vcTitle: source.name, parameters: [kSOURCES: source.id])
        default: //titles
            break
        }
    }
}

//MARK: CollectionView Data Source Extension
extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case is TitleSection:
            let section = sections[indexPath.section] as! TitleSection
            return section.configureCell(collectionView: collectionView, indexPath: indexPath)
        case is ImageSection:
            let section = sections[indexPath.section] as! ImageSection
            return section.configureCell(collectionView: collectionView, indexPath: indexPath)
        case is LabelSection:
            let section = sections[indexPath.section] as! LabelSection
            return section.configureCell(collectionView: collectionView, indexPath: indexPath)
        default:
            return sections[indexPath.section].configureCell(collectionView: collectionView, indexPath: indexPath)
        }
    }
}

// MARK: - Search bar functions
extension HomeVC: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            coordinator?.goToNewsList(endpoint: .articles, vcTitle: "\(textField.text!) News", parameters: [kQ: textField.text!])
        }
        return true
    }
}
