//
//  LabelSection.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

struct LabelSection: Section {
    
    var titles: [String]
    var numberOfItems = 1

    init(titles: [String]) {
        self.titles = titles
        self.numberOfItems = titles.count
    }
    
    func layoutSection() -> NSCollectionLayoutSection {
        // Step 1:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.3))
        // Step 2:
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0)
        // Step 3: Try using 95% width and 35% height
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(0.3))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(0.35))
        // Step 4: You will need to specify how many items per group (3)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        // Step 5:
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    //Step 6:
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LabelCell.self), for: indexPath) as! LabelCell
        let title = self.titles[indexPath.row]
        cell.set(title: title)
        return cell
    }
}
