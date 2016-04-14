//
//  CardsViewFlowLayout.swift
//  Swiping Carousel
//
//  Created by Pablo Surfate on 8/20/15.
//  Copyright (c) 2015 Pablo Paciello. All rights reserved.
//

import UIKit


class CardsViewFlowLayout:  UICollectionViewFlowLayout {
    
    // Mark: Constants
    private struct CardsViewFlowConstants {
        static let activeDistance: CGFloat = 100
        static let zoomFactor: CGFloat = 0.2
        static let itemWidth: CGFloat = 54       //Width of the Cell.
        static let itemHeight: CGFloat = 94      //Height of the Cell.
        static let minLineSpacing: CGFloat = 30.0
        
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = CGSizeMake(CardsViewFlowConstants.itemWidth, CardsViewFlowConstants.itemHeight)
        scrollDirection = .Horizontal
        minimumLineSpacing = CardsViewFlowConstants.minLineSpacing
        //These numbers will depend on the size of your cards you have set in the CardsViewFlowConstants.
        //60 - will let the first and last card of the CollectionView to be centered.
        //100 - will avoid the double rows in the CollectionView
        sectionInset = UIEdgeInsetsMake(-64.0, (collectionView!.bounds.width/2) + (CardsViewFlowConstants.itemWidth), 0.0, (collectionView!.bounds.width/2) + (CardsViewFlowConstants.itemWidth))
    }
    
    // Here is where the magic happens
    // Add zooming to the Layout Attributes.
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //        print("layoutAttributesForElementsInRect")
        let array = super.layoutAttributesForElementsInRect(rect)
        
        var visibleRect = CGRect()
        visibleRect.origin = collectionView!.contentOffset
        visibleRect.size = collectionView!.bounds.size
        
        for attributes in array! {
            let newAttributes: UICollectionViewLayoutAttributes = attributes
            if CGRectIntersectsRect(attributes.frame, rect) {
                let distance = CGRectGetMidX(visibleRect) - attributes.center.x
                let normalizedDistance = distance / CardsViewFlowConstants.activeDistance
                if (abs(distance)) < CardsViewFlowConstants.activeDistance {
                    let zoom = 1 + CardsViewFlowConstants.zoomFactor*(1 - abs(normalizedDistance))
                    newAttributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
                    newAttributes.zIndex = 1
                }
            }
        }
        return array
    }
    
    //Focus the zoom in the middle Card.
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if collectionView?.contentOffset.x <= 0 {
            return CGPointMake(proposedContentOffset.x, proposedContentOffset.y)
        }
        
        var offsetAdjustment:CGFloat = CGFloat(MAXFLOAT)
        let horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0)
        
        let targetRect = CGRectMake(proposedContentOffset.x, 0.0, collectionView!.bounds.size.width, collectionView!.bounds.size.height)
        
        if let array = super.layoutAttributesForElementsInRect(targetRect) {
            for layoutAttributes in array {
                let itemHorizontalCenter: CGFloat = layoutAttributes.center.x
                if (abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment)) {
                    offsetAdjustment = itemHorizontalCenter - horizontalCenter
                }
            }
        }
        return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y)
    }
    
    
    // Invalidate the Layout when the user is scrolling
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
}
