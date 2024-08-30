//
//  PaymentCollectonView.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension PaymentsVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CardModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentModeCollectionViewCell.className, for: indexPath) as? PaymentModeCollectionViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.btnDeleteRef.tag = indexPath.row
        cell.btnDeleteRef.addTarget(self, action: #selector(btnDeleteTap(_sender:)), for: .touchUpInside)
        cell.configureWith(data: CardModelArray[indexPath.row])
        return cell
    }
}


extension PaymentsVC:UICollectionViewDelegate{
    
}

extension PaymentsVC:UICollectionViewDelegateFlowLayout{
    //TODO: CollectionView flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 301 - 10, height:170)
    }
}
