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
        view.backgroundColor = UIColor(red:0.439,  green:0.411,  blue:0.927, alpha:1)
        collectionView?.frame = CGRectMake(0, view.bounds.maxY - 120, view.bounds.width, 120)
        collectionView?.bounces = true
        collectionView?.clipsToBounds = false
        collectionView?.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: Model
    // Load allTheCards from SavedCards Class.
    private var allTheCards = SavedCards.loadCards()
    
    
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
  

}