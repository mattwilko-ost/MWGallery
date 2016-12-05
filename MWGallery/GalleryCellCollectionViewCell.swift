//
//  GalleryCellCollectionViewCell.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 05/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

protocol GalleryCellDelegate: class {
    func galleryCell(cell: GalleryCellCollectionViewCell, didZoomToScale scale:CGFloat)
}

class GalleryCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate:GalleryCellDelegate?
}

extension GalleryCellCollectionViewCell: UIScrollViewDelegate {
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        delegate?.galleryCell(self, didZoomToScale: scrollView.zoomScale)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}