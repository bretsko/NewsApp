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
        numberOfItems = categories.count
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.54))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300)) //absolute height
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as! ImageCell
        let category = self.categories[indexPath.row]
        cell.setContents(title: category.rawValue, image: category.image)
        return cell
    }
}

