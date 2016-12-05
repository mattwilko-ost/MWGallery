//
//  ZoomLayout.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 02/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

class ZoomLayout: UICollectionViewFlowLayout {
    
    var page: Int = 0

    func commonInit() {
        scrollDirection = .Horizontal
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareLayout() {
        itemSize = collectionView!.frame.size
        super.prepareLayout()
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let targetOffset = super.targetContentOffsetForProposedContentOffset(proposedContentOffset, withScrollingVelocity: velocity)
        page = Int(targetOffset.x / collectionView!.frame.width)
        return targetOffset
    }
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
             return CGPoint.zero
        }
        
        let newWidth = collectionView.bounds.width  
        let newOffsetX = CGFloat(page) * newWidth
        
        return CGPoint(x: newOffsetX, y: 0)
    }
    
    
    
}
