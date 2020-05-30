//
//  ShearLayout.swift
//  CollectionViewLayouts
//
//  Created by Ahmed Fathi on 5/30/20.
//  Copyright © 2020 Ahmed Fathi. All rights reserved.
//

import UIKit

class ShearLayout: UICollectionViewLayout {
    
    
    // Constants
    private let contentInsets = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
    private let itemHeight: CGFloat = 120
    private let outsideItemMargin: CGFloat = 16
    private let interitemSpace: CGFloat = 8
    private let rotationAngle: CGFloat = -1 * 0.06 * .pi
    
    // Book keeping
    private var itemCount = 0
    private var itemSize: CGSize = .zero
    private var itemHeightAndSpace: CGFloat {
        itemHeight + interitemSpace
    }
    private var contentHeight: CGFloat {
        (CGFloat(itemCount) * itemHeight) +
            (CGFloat(itemCount - 1) * interitemSpace) +
            (contentInsets.top + contentInsets.bottom)
    }
    
    // Cache
    private var layoutAttributes: [ParallaxLayoutAttributes] = []
    
    
    // MARK: - ContentSize
    
    override var collectionViewContentSize: CGSize {
        guard let cv = collectionView else { return .zero }
        return CGSize(width: cv.bounds.width, height: contentHeight)
    }
    
    // MARK: - Prepare
    
    override func prepare() {
        super.prepare()
        
        guard let cv = collectionView else { return }
        
        itemCount = cv.numberOfItems(inSection: 0)
        itemSize = CGSize(
            width: cv.bounds.width + (outsideItemMargin * 2.0),
            height: itemHeight)
        
        
        layoutAttributes = []
        var currentY: CGFloat = contentInsets.top
        
        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = ParallaxLayoutAttributes(forCellWith: indexPath)
            
            attributes.size = itemSize
            
            let xCenter = cv.bounds.midX
            let yCenter = currentY + (itemHeight / 2.0)
            attributes.center = CGPoint(x: xCenter, y: yCenter)
            
            layoutAttributes.append(attributes)
            
            currentY += itemHeightAndSpace
        }
        
    }
    
    // MARK: - Layout Attributes
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        for attributes in layoutAttributes where rect.intersects(attributes.frame) {
            attributes.transform = getTransform(for: attributes)
            attributes.parallax = getParallax(for: attributes)
        }
        
        return layoutAttributes.filter { rect.intersects($0.frame) }
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        layoutAttributes.filter { $0.indexPath == indexPath }.first
        
    }
    
    // MARK: - Layout invalidations
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        if context.invalidateEverything || context.invalidateDataSourceCounts {
            layoutAttributes = []
        }
        super.invalidateLayout(with: context)
    }
    
    // MARK: - Transform Helpers
    
    private func getTransform(for attributes: UICollectionViewLayoutAttributes) -> CGAffineTransform {
        CGAffineTransform.identity.rotated(by: rotationAngle)
    }
    
    private func getParallax(for attributes: UICollectionViewLayoutAttributes) -> CGFloat {
        guard let cv = collectionView else { return .zero }
        
        let visibleRect = CGRect(origin: cv.contentOffset, size: cv.bounds.size)
        
        let currentY = attributes.center.y
        let centerY = visibleRect.midY
        let difference = currentY - centerY
        let parallax = difference * 0.2
        
        return parallax
    }
    
}




