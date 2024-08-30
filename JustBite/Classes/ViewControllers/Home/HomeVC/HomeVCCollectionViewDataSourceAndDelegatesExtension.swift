//
//  HomeVCCollectionViewDataSourceAndDelegatesExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellAvailableOffer.className, for: indexPath) as? HomeCollectionViewCellAvailableOffer else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.moveToNextViewC(name: "Home", withIdentifier: RestaurentDetailsVC.className)
    }

}

extension HomeVC:UICollectionViewDelegate{
    
}

extension HomeVC:UICollectionViewDelegateFlowLayout{
    //TODO: CollectionView flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 290, height:160)
    }
}
