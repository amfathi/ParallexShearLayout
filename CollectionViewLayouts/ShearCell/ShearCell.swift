//
//  ShearCell.swift
//  CollectionViewLayouts
//
//  Created by Ahmed Fathi on 5/30/20.
//  Copyright © 2020 Ahmed Fathi. All rights reserved.
//

import UIKit

class ShearCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attributes = layoutAttributes as? ParallaxCollectionViewLayoutAttributes {
            let transform = CGAffineTransform.identity.translatedBy(x: 0, y: attributes.parallax)
            imageView.transform = transform
        }
    }
    
}
