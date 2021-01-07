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
    
   
    //MARK: - table sections
    
    enum TableSection: Int  {
        
        case category = 1
        case country = 3
        case languages = 5
        case sources = 7
        
        var name: String {
            switch self {
            case .category:
                return "Categories"
            case .country:
                return "Countries"
            case .languages:
                return "Languages"
            case .sources:
                return "Sources"
            }
        }
    }
    
    private var sections: [Section] = [
        
        TitleSection(title: TableSection.category.name),
        ImageSection(categories: Category.allCases),
        
        TitleSection(title: TableSection.country.name),
        BodySection(cellNames: Country.allCases.map { $0.rawValue }),
        
        TitleSection(title: TableSection.languages.name),
        BodySection(cellNames: Language.allCases.map { $0.rawValue }),
        
        TitleSection(title: TableSection.sources.name),
        BodySection(cellNames: []) // keep it empty for now as we fetch sources
    ]
    
    func getBodySection(_ titleSection: TableSection) -> BodySection {
        sections[titleSection.rawValue] as! BodySection
    }
    
    func setSection(_ titleSection: TableSection,
                     with bodySection: BodySection) {
        sections[titleSection.rawValue] = bodySection
    }
    
    var sources: [Source] = [] {
        didSet {
            let bodySection = BodySection(cellNames: sources.map { $0.name })
            setSection(.sources,
                       with: bodySection)
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
        NetworkManager.shared.numArticlesOnBackend = 0
        
    }
    
    //MARK: - setup UI
    
    private func setupViews() {
        navigationItem.title = "News Stand"
        setupCollectionView()
        setupSearchBar()
        loadAllSources()
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
    private func loadAllSources() {
        NetworkManager.shared.fetchAllSources { result in
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else {
                    return
                }
                switch result {
                case let .success(sources):
                    weakSelf.sources = sources
                case let .failure(error):
                    weakSelf.presentAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let tableSection = TableSection(rawValue: indexPath.section) else {
            // titles
            return
        }
        
        let endpoint: EndPoint
        let vcTitle: String
        
        switch tableSection {
        case .category:
            let section = sections[indexPath.section] as! ImageSection
            let category = section.categories[indexPath.row]
            // ?? 2 ways to get category ?
            vcTitle = Category.allCases[indexPath.row].rawValue + " News"
            fatalError()
            //endpoint = .category(category)
            
        case .country:
            let country = Country.allCases[indexPath.row]
            vcTitle = country.rawValue + " News"
            fatalError()
            //endpoint = .country(country)
            
        case .languages:
            let language = Language.allCases[indexPath.row]
            vcTitle = language.rawValue + " News"
            let sourcesQueryString = Language.getSourcesString(language: language.rawValue, sources: sources)
            if sourcesQueryString.isEmpty {
                fatalError()
            }
            fatalError()
            //endpoint = .language(language, sourcesQueryString)
            
        case .sources:
            let source = sources[indexPath.row]
            vcTitle = source.name
            let filterOption = FilterOption.source(source)
            fatalError()
            //endpoint = .source(Set([filterOption]))
        }
        coordinator?.goToNewsList(endpoint: endpoint, vcTitle: vcTitle)
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
        
        let section = sections[indexPath.section]
        
        if let sect = section as? TitleSection {
            return sect.configureCell(in: collectionView,
                                      at: indexPath)
        } else if let sect = section as? ImageSection {
            return sect.configureCell(in: collectionView,
                                      at: indexPath)
        } else if let sect = section as? BodySection {
            return sect.configureCell(in: collectionView,
                                      at: indexPath)
        } else {
            return section.configureCell(in: collectionView,
                                         at: indexPath)
        }
    }
}

//MARK: - UISearchTextFieldDelegate

extension HomeVC: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text  {
            let filter = FilterOption.query(text)
            coordinator?.goToNewsList(endpoint: .search(Set([filter])),
                                      vcTitle: text + " News")
        }
        return true
    }
}
