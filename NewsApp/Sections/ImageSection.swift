//
//  MovieSection.swift
//  NewsApp
//
//  Created by Samuel Folledo on 4/7/20.
//  Copyright © 2020 Samuel Folledo. All rights reserved.
//

import UIKit

struct ImageSection: Section {
    
    var categories: [Category]
    
    var numberOfItems = 0
    
    var items: [String]!
    
    init(categories: [Category]) {
        self.categories = categories
        self.numberOfItems = categories.count
    }
    
    
    //MARK: -
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)) // fit 2 cells horizontally each group
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5) // put space in between each items
        //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .fractionalHeight(0.5)) //how wide and tall each group of cell by the width and height of collectionView, width will show a little part of the next group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(250)) // absolute height
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        return section
    }
    
    func configureCell(in collectionView: UICollectionView,
                       at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as! ImageCell
        let category = categories[indexPath.row]
        cell.setContents(title: category.rawValue, image: category.image)
        return cell
    }
}
