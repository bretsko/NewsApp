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
        collectionView.collectionViewLayout = CategoryFlowLayout()
//        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: String(describing: CategoryCell.self)) //no need since it's inside collectionView's story
    }
    
    fileprivate func addDummyData() {
        categories = [
            Category(name: "Business", news: [News(title: "Stocks up", body: "Stocks up"), News(title: "Stocks down", body: "Stocks down"), ]),
            Category(name: "Health", news: [News(title: "Health up", body: "Health up"), News(title: "Health down", body: "Health down"), ]),
            Category(name: "Economy", news: [News(title: "Economy up", body: "Economy up"), News(title: "Economy down", body: "Economy down"), ]),
            Category(name: "Business2", news: [News(title: "Stocks up", body: "Stocks up"), News(title: "Stocks down", body: "Stocks down"), ]),
            Category(name: "Health2", news: [News(title: "Health up", body: "Health up"), News(title: "Health down", body: "Health down"), ]),
            Category(name: "Economy2", news: [News(title: "Economy up", body: "Economy up"), News(title: "Economy down", body: "Economy down"), ]),
            Category(name: "Business3", news: [News(title: "Stocks up", body: "Stocks up"), News(title: "Stocks down", body: "Stocks down"), ]),
            Category(name: "Health3", news: [News(title: "Health up", body: "Health up"), News(title: "Health down", body: "Health down"), ]),
            Category(name: "Economy3", news: [News(title: "Economy up", body: "Economy up"), News(title: "Economy down", body: "Economy down"), ]),
        ]
        collectionView.reloadData()
    }
    
//MARK: IBActions
    
    
//MARK: Helper Methods

}

//MARK: Extensions
extension HomeVC: UICollectionViewDelegate {}

//extension HomeVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.safeAreaLayoutGuide.layoutFrame.width / 2 - 24, height: self.view.safeAreaLayoutGuide.layoutFrame.height / 3 - 30)
//    }
//}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
        cell.category = category
        cell.backgroundColor = .gray
        return cell
    }
}
