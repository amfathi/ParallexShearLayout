//
//  ParallaxLayoutAttributes.swift
//  CollectionViewLayouts
//
//  Created by Ahmed Fathi on 5/30/20.
//  Copyright © 2020 Ahmed Fathi. All rights reserved.
//

import UIKit

class ParallaxLayoutAttributes: UICollectionViewLayoutAttributes {
    var parallax: CGFloat = 0
    
    // MARK: NSCopying
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! ParallaxLayoutAttributes
        copy.parallax = self.parallax
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? ParallaxLayoutAttributes {
           if parallax != rhs.parallax {
              return false
           }
           return super.isEqual(object)
        } else {
           return false
        }
    }
}
