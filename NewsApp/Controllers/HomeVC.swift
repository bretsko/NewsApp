//
//  HomeVC.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 4/23/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var searchController: UISearchController!
    
    weak var coordinator: MainCoordinator?
    
    var sections: [Section] = [
        
        TitleSection(title: "Categories"),
        ImageSection(categories: Category.allCases),
        
        TitleSection(title: "Countries"),
        LabelSection(titles: Country.allCases.map { $0.rawValue }),
        
        TitleSection(title: "Languages"),
        LabelSection(titles: Language.allCases.map { $0.rawValue }),
        
        TitleSection(title: "Sources"),
        LabelSection(titles: []) // keep it empty for now as we fetch sources
    ]

    var sources: [Source] = [] {
        didSet {
            sections[7] = LabelSection(titles: sources.map { $0.name })
            collectionView.reloadData()
        }
    }
    
    
    //MARK: - App LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.shared.resetNetworkManager()
    }
    
    //MARK: - setup UI

    private func setupViews() {
        navigationItem.title = "News Stand"
        setupCollectionView()
        setupSearchBar()
        fetchSources()
    }
    
    private func setupSearchBar() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.tintColor = .white
        searchBar.barTintColor = UIColor.blue
        searchBar.returnKeyType = .search
        searchBar.tintColor = .darkGray
        
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Search for News"
        searchBar.searchTextField.clearButtonMode = .always

        
        // cancel button
        searchController.searchBar.showsCancelButton = false
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissTap(_:)))
        toolBar.setItems([flexibleBar, cancelButton], animated: true)
        searchBar.searchTextField.inputAccessoryView = toolBar
               
        navigationItem.searchController = searchController
    }
    
    private func setupCollectionView() {
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            self.sections[sectionIndex].layoutSection()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        //        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self)) //no need since it's inside collectionView's story
        collectionView.register(UINib(nibName: TitleCell.identifier, bundle: .main), forCellWithReuseIdentifier: TitleCell.identifier)
        collectionView.register(UINib(nibName: ImageCell.identifier, bundle: .main), forCellWithReuseIdentifier: ImageCell.identifier)
        collectionView.register(UINib(nibName: LabelCell.identifier, bundle: .main), forCellWithReuseIdentifier: LabelCell.identifier)
    }
    
    
    //MARK: - IBActions
    
    @objc func handleDismissTap(_ gesture: UITapGestureRecognizer) {
        searchController.searchBar.endEditing(false)
    }
    
    
    //MARK: -

    /// fetches a list of sources which is needed to fetch articles by language and by source
    private func fetchSources() {
        NetworkManager.shared.fetchSources { result in
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else {
                    return
                }
                switch result {
                case let .success(sources):
                    weakSelf.sources.append(contentsOf: sources)
                case let .failure(error):
                    Service.presentAlert(on: weakSelf, title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 1: // fetch articles by categories
            let section = sections[indexPath.section] as! ImageSection
            let category = section.categories[indexPath.row]
            let vcTitle = Category.allCases[indexPath.row].rawValue + " News"
            coordinator?.goToNewsList(endpoint: .category, vcTitle: vcTitle, parameters: ["category": category.rawValue])
            
        case 3: // fetch articles by countries
            let country = String(describing: Country.allCases[indexPath.row]) // convert enum case to string
            let vcTitle = Country.allCases[indexPath.row].rawValue + " News"
            coordinator?.goToNewsList(endpoint: .country, vcTitle: vcTitle, parameters: ["country": country])
            
        case 5: // fetch articles by language
            let language = String(describing: Language.allCases[indexPath.row])
            let vcTitle = Language.allCases[indexPath.row].rawValue + " News"
            let sourcesQueryString = Language.getSourcesString(language: language, sources: sources) // fetching articles by language requires sources query
            coordinator?.goToNewsList(endpoint: .language, vcTitle: vcTitle, parameters: ["language": language, "sources": sourcesQueryString])
            
        case 7: // fetch articles by source
            let source = sources[indexPath.row]
            coordinator?.goToNewsList(endpoint: .source, vcTitle: source.name, parameters: ["sources": source.id])
        default: // titles
            break
        }
    }
}

//MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].numberOfItems
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

//MARK: - UISearchTextFieldDelegate

extension HomeVC: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            coordinator?.goToNewsList(endpoint: .articles, vcTitle: "\(textField.text!) News", parameters: ["q": textField.text!])
        }
        return true
    }
}
