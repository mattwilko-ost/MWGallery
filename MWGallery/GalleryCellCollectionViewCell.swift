//
//  GalleryCellCollectionViewCell.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 05/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

protocol GalleryCellDelegate: class {
    func didTapGalleryCell(cell: GalleryCellCollectionViewCell)
    func galleryCell(cell: GalleryCellCollectionViewCell, didZoomToScale scale:CGFloat)
}

final class GradientView: UIView {
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
}

class GalleryCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoView: GradientView!
    
    weak var delegate:GalleryCellDelegate?
    
    
    
    var showingZoomedImage = false {
        didSet {
            self.infoView.alpha = self.showingZoomedImage ? 1 : 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGestureRecognisers()
        (infoView.layer as! CAGradientLayer).colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
    }
    
    func setupGestureRecognisers() {
        let oneTapGesture = UITapGestureRecognizer(target: self, action: #selector(GalleryCellCollectionViewCell.handleOneTapGesture))
        oneTapGesture.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(oneTapGesture)
        
        let twoTapGesture = UITapGestureRecognizer(target: self, action: #selector(GalleryCellCollectionViewCell.handleTwoTapGesture))
        twoTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(twoTapGesture)
        
        oneTapGesture.requireGestureRecognizerToFail(twoTapGesture)
    }
    
    func configureCell() {

    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        UIView.animateWithDuration(0.33) { 
            self.layoutIfNeeded()
        }
    }
    
    func handleOneTapGesture() {
        if scrollView.userInteractionEnabled {
            delegate?.didTapGalleryCell(self)
        }
    }
    
    func handleTwoTapGesture(sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoomToRect(zoomRectForScale(scrollView.maximumZoomScale, center: sender.locationInView(sender.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convertPoint(center, fromView: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
}

extension GalleryCellCollectionViewCell: UIScrollViewDelegate {
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        delegate?.galleryCell(self, didZoomToScale: scrollView.zoomScale)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        UIView.animateWithDuration(0.1) {
            self.infoView.alpha = 0.0
        }
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if scale <= 1.0 {
            UIView.animateWithDuration(0.1) {
                self.infoView.alpha = 1.0
            }
        }
    }
    
}