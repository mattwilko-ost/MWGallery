//
//  ViewController.swift
//  MWGallery
//
//  Created by Matthew Wilkinson on 02/12/2016.
//  Copyright © 2016 Matthew Wilkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    private var showingZoomedImage = false
    private var hiddenHUD = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridButton.hidden = !showingZoomedImage
    }
    
    @IBAction func didTapGridButton(sender: UIButton) {
        guard showingZoomedImage else {
            return
        }
        showingZoomedImage = false
        gridButton.hidden = !showingZoomedImage
        let layout = GridLayout(oldLayout: collectionView.collectionViewLayout)
        collectionView.setCollectionViewLayout(layout, animated: true, completion: nil)
        
        for cell in collectionView.visibleCells() as! [GalleryCellCollectionViewCell] {
            cell.scrollView.userInteractionEnabled = false
            cell.scrollView.zoomScale = 1
            cell.showingZoomedImage = showingZoomedImage
        }
    }
    
    @IBAction func didTapCloseButton(sender: UIButton) {
        
    }
    
    func didTapGalleryCell(cell: GalleryCellCollectionViewCell) {
        hiddenHUD = !hiddenHUD
        if showingZoomedImage {
            UIView.animateWithDuration(0.3) {
                for cell in self.collectionView.visibleCells() as! [GalleryCellCollectionViewCell] {
                    cell.showingZoomedImage = !cell.showingZoomedImage
                }
            }
        }
    }
    
    // MARK: - View Rotation
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        guard let collectionView = collectionView,
              let flowLayout = collectionView.collectionViewLayout as? ZoomLayout else {
            return
        }
        
        if !CGSizeEqualToSize(flowLayout.itemSize, size) {
            for cell in collectionView.visibleCells() as! [GalleryCellCollectionViewCell] {
                cell.scrollView.zoomScale = 1
            }
            flowLayout.oldLayout = nil
            flowLayout.itemSize = collectionView.frame.size
            flowLayout.invalidateLayout()
        }
        
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
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
        cell.showingZoomedImage = hiddenHUD ? false : showingZoomedImage
        cell.configureCell()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! GalleryCellCollectionViewCell
        cell.configureCell()
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard !showingZoomedImage else {
            return
        }
        showingZoomedImage = true
        gridButton.hidden = !showingZoomedImage
        
        for cell in collectionView.visibleCells() as! [GalleryCellCollectionViewCell] {
            cell.scrollView.userInteractionEnabled = true
        }
        
        collectionView.pagingEnabled = true
        let layout = ZoomLayout(oldLayout: collectionView.collectionViewLayout)
        layout.page = indexPath.row
        layout.itemSize = collectionView.bounds.size
        collectionView.setCollectionViewLayout(layout, animated: true, completion: nil)
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! GalleryCellCollectionViewCell
        cell.showingZoomedImage  = hiddenHUD ? false : showingZoomedImage
    }
    
}

extension ViewController: GalleryCellDelegate {
    
    func galleryCell(cell: GalleryCellCollectionViewCell, didZoomToScale scale: CGFloat) {

    }
    
}

