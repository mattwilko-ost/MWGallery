//
//  ViewController.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 02/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private var showingZoomedImage = false
    private var animatingTransition = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("default", forIndexPath: indexPath) as! GalleryCellCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.imageView.image = UIImage(named: "1")
        case 1:
            cell.imageView.image = UIImage(named: "2")
        case 2:
            cell.imageView.image = UIImage(named: "3")
        case 3:
            cell.imageView.image = UIImage(named: "4")
        case 4:
            cell.imageView.image = UIImage(named: "5")
        default:
            break
        }
        
        cell.scrollView.userInteractionEnabled = showingZoomedImage
        cell.scrollView.zoomScale = 1
        cell.delegate = self
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !showingZoomedImage {
            showingZoomedImage = true
            for cell in collectionView.visibleCells() as! [GalleryCellCollectionViewCell] {
                cell.scrollView.userInteractionEnabled = true
            }
            collectionView.pagingEnabled = true
            let layout = ZoomLayout()
            layout.page = indexPath.row
            layout.itemSize = collectionView.bounds.size
            collectionView.startInteractiveTransitionToCollectionViewLayout(layout, completion: { completed, _ in
                if completed {
                    
                }
            })
            collectionView.finishInteractiveTransition()
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        guard let flowLayout = collectionView?.collectionViewLayout as? ZoomLayout else {
            return
        }
        
        if !CGSizeEqualToSize(flowLayout.itemSize, size) {
            for cell in collectionView!.visibleCells() as! [GalleryCellCollectionViewCell] {
                cell.scrollView.zoomScale = 1
            }
            flowLayout.itemSize = self.collectionView!.frame.size
            flowLayout.invalidateLayout()
        }
    }
}

extension ViewController: GalleryCellDelegate {
    
    func galleryCell(cell: GalleryCellCollectionViewCell, didZoomToScale scale: CGFloat) {
        if scale < 0.7 && showingZoomedImage {
            showingZoomedImage = false
            cell.scrollView.pinchGestureRecognizer?.enabled = false
            cell.scrollView.pinchGestureRecognizer?.enabled = true
            cell.scrollView.zoomScale = 1
            for cell in collectionView!.visibleCells() as! [GalleryCellCollectionViewCell] {
                cell.scrollView.userInteractionEnabled = false
                cell.scrollView.zoomScale = 1
                cell.scrollView.scrollEnabled = false
            }
            collectionView!.pagingEnabled = false
            let layout = GridLayout()
            collectionView!.startInteractiveTransitionToCollectionViewLayout(layout, completion: { completed, _ in
                
            })
            collectionView?.finishInteractiveTransition()
        }
    }
    
}

