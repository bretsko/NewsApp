//
//  Section.swift
//  NewsApp
//
//  Created by Macbook Pro 15 on 5/8/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

protocol Section {
    
    var numberOfItems: Int { get }
    
    func layoutSection() -> NSCollectionLayoutSection
    
    func configureCell(in collectionView: UICollectionView,
                       at indexPath: IndexPath) -> UICollectionViewCell
}
