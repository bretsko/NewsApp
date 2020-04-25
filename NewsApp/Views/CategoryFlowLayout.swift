//
//  CategoryFlowLayout.swift
//  MobileClasswork
//
//  Created by Macbook Pro 15 on 2/11/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class CategoryFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        guard let cv = collectionView else { return }
        //self.itemSize = CGSize(width: cv.bounds.inset(by: cv.layoutMargins).size.width, height: 70.0)
        self.sectionInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        self.sectionInsetReference = .fromSafeArea
        //get width
        let availableWidth = cv.bounds.inset(by: cv.layoutMargins).size.width //width of collectionView
        let minColumnWidth = CGFloat(300)
        let maxNumColumns = Int(availableWidth/minColumnWidth)
        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down) / 2 - 10
        //custom height height
//        let availableHeight = cv.bounds.inset(by: cv.layoutMargins).size.height //width of collectionView
//        let minColumnHeight = CGFloat(300)
//        let maxNumRows = Int(availableHeight/minColumnHeight)
//        let cellHeight = (availableHeight / CGFloat(maxNumRows)).rounded(.down) / 3 - 16
        self.itemSize = CGSize(width: cellWidth, height: cellWidth) //To make it square
    }
}

