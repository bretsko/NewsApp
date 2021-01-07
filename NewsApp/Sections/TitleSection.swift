//
//  TitleSection.swift
//  NewsApp
//
//  Created by Samuel Folledo on 4/7/20.
//  Copyright © 2020 Samuel Folledo. All rights reserved.
//

import UIKit

struct TitleSection: Section {
    
    let numberOfItems = 1
    let title: String
    
//    init(title: String) {
//        self.title = title
//    }
    
    //MARK: -
    
    func layoutSection() -> NSCollectionLayoutSection {
        // Step 1:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        // Step 2:
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Step 3:
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        // Step 4:
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // Step 5:
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // Step 6:
    func configureCell(in collectionView: UICollectionView,
                       at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
        cell.set(title: title)
        return cell
    }
}
