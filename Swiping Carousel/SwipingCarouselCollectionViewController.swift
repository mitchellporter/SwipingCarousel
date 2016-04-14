//
//  SwipingCarouselCollectionViewController.swift
//  Swiping Carousel
//
//  Created by Pablo Surfate on 8/20/15.
//  Copyright (c) 2015 Pablo Paciello. All rights reserved.
//

import UIKit

let reuseIdentifier = "Card"

class SwipingCarouselCollectionViewController: UICollectionViewController, CardViewCellDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.frame = CGRectMake(0, 200, view.bounds.width, 204)
        collectionView?.bounces = true
    }
    
    // MARK: Model
    // Load allTheCards from SavedCards Class.
    private var allTheCards = SavedCards.loadCards()
    
    private struct Constants {
        static let LikedImage = "Liked"
        static let DislikedImage = "Disliked"
        static let SegueIdentifier = "OpenChat"
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Return the number of items in the section
        return allTheCards.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CardCollectionViewCell
        
        // Configure the cell
        let currentCard = allTheCards[indexPath.row]
        cell.profileImage.image = currentCard.image
        cell.backgroundColor = currentCard.backgroundColor
        cell.delegate = self
        return cell
    }
    
    
    //MARK: Segue Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == Constants.SegueIdentifier {
            if let selectedRowIndex = collectionView!.indexPathsForSelectedItems()!.last {
                if let cell = collectionView?.cellForItemAtIndexPath(selectedRowIndex) {
                    //We check if the selected Card is the one in the middle to open the chat. If it's not, we scroll to the side card selected.
                    if cell.frame.size.height > cell.bounds.size.height {
                        return true
                    } else {
                        collectionView?.scrollToItemAtIndexPath(selectedRowIndex, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
                        return false
                    }
                }
            }
        }
        
        return true
    }
}