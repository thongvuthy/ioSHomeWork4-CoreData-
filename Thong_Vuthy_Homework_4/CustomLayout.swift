//
//  CustomLayout.swift
//  Thong_Vuthy_Homework_4
//
//  Created by Adimax Lee on 20/12/17.
//  Copyright © 2017 Adimax Lee. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    var innerSpace: CGFloat = 8.0
    let numberOfCellsOnRow: CGFloat = 2
    
    
    override init() {
        super.init()
        self.minimumLineSpacing = innerSpace
        self.minimumInteritemSpacing =  innerSpace
        self.sectionInset = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 2.0, right: 8.0 )
        self.scrollDirection = .vertical
    }
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.size.width/self.numberOfCellsOnRow - 4.0) - (self.innerSpace)
    }
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width:itemWidth(), height:itemWidth())
        }
        get {
            return CGSize(width:itemWidth(),height:itemWidth())
        }
    }
    
}
