//
//  GalleryCellCollectionViewCell.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 05/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

class GalleryCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
}

extension GalleryCellCollectionViewCell: UIScrollViewDelegate {
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}