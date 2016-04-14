//
//  CardCollectionViewCell.swift
//  Swiping Carousel
//
//  Created by Pablo Surfate on 8/20/15.
//  Copyright (c) 2015 Pablo Paciello. All rights reserved.
//

import UIKit

//Protocol to inform its delegate of a Card being swiped up or down.
protocol CardViewCellDelegate : class {
}

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var mainDescriptionLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    weak var delegate: CardViewCellDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        // Cell Corner and Shadows
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.6
        // Emphasize the shadow on the bottom and right sides of the cell
        self.layer.shadowOffset = CGSizeMake(4, 4)
        
    }
    
    // MARK: Gestures Handling
    
    
    var swipeDistanceOnY = CGFloat() //Distance of the swipe over "y" axis.
    var originalPoint = CGPoint()
    
}
