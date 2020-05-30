//
//  ViewController.swift
//  CollectionViewLayouts
//
//  Created by Ahmed Fathi on 5/30/20.
//  Copyright © 2020 Ahmed Fathi. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            setupCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let shearNib = UINib(nibName: "ShearCell", bundle: nil)
        collectionView.register(shearNib, forCellWithReuseIdentifier: "shearCell")
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shearCell", for: indexPath) as! ShearCell
        
        let image = UIImage(named: "image-\(indexPath.row % 5)")!
        cell.imageView.image = image
        
        return cell
    }
    
    
}
