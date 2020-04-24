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
    var categories: [Category] = []
    
//MARK: Views
    @IBOutlet weak var collectionView: UICollectionView!
    
    
//MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

//MARK: Private Methods
    fileprivate func setupViews() {
        self.title = "NewsStand"
        setupCollectionView()
        addDummyData()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self))
    }
    
    fileprivate func addDummyData() {
        categories = [
            Category(name: "Business", news: [News(title: "Stocks up", body: "Stocks up"), News(title: "Stocks down", body: "Stocks down"), ]),
            Category(name: "Health", news: [News(title: "Health up", body: "Health up"), News(title: "Health down", body: "Health down"), ]),
            Category(name: "Economy", news: [News(title: "Economy up", body: "Economy up"), News(title: "Economy down", body: "Economy down"), ]),
        ]
        collectionView.reloadData()
    }
    
//MARK: IBActions
    
    
//MARK: Helper Methods

}

//MARK: Extensions
extension HomeVC: UICollectionViewDelegate {
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
        cell.backgroundColor = .red
        cell.populateViews(category: category)
//        cell.lbl.text = "\(category.name)"
        return cell
    }
}
