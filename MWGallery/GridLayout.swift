//
//  GridLayout.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 02/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    func commonInit() {
        scrollDirection = .Vertical
        itemSize = CGSize(width: 100, height: 100)
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}
