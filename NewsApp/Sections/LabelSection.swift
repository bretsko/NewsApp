//
//  LabelSection.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct LabelSection: Section {
    let numberOfItems = 1
    let title: String

    init(title: String) {
        self.title = title
    }
    
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
    
    //Step 6:
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCell.self), for: indexPath) as! TitleCell
        cell.set(title: title)
        return cell
    }
}
