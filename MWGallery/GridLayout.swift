//
//  GridLayout.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 02/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    var oldLayout: UICollectionViewLayout?

    init(oldLayout: UICollectionViewLayout) {
        self.oldLayout = oldLayout
        super.init()
        commonInit()
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        scrollDirection = .Vertical
        itemSize = CGSize(width: 100, height: 100)
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let oldLayout = oldLayout else {
            return super.initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath)
        }
        
        let attributes = oldLayout.layoutAttributesForItemAtIndexPath(itemIndexPath)
        return attributes
    }
    
    override func finalizeLayoutTransition() {
        super.finalizeLayoutTransition()
        oldLayout = nil
    }

}
