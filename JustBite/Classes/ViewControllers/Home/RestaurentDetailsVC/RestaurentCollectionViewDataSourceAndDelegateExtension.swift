//
//  RestaurentCollectionViewDataSourceAndDelegateExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension RestaurentDetailsVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.row
        print("self.index",self.index)
        self.catIndex = indexPath.row
        
        macroObj.hideLoaderEmpty(view: self.tblCart)
        macroObj.hideLoaderNet(view: self.tblCart)
        macroObj.hideWentWrong(view: self.tblCart)
        if categoryDataModelArray.contains(where: {$0.isSelected == true}){
            if let index = categoryDataModelArray.firstIndex(where: {$0.isSelected == true}){
                categoryDataModelArray[index].isSelected = false
                categoryDataModelArray[indexPath.row].isSelected = true
                
                let realm = try! Realm()
                var id = String()
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    id = userInfo.id
                    print("category is-->",id)
                }else{
                    print("do nothing")
                }
                self.menulisService(catId:categoryDataModelArray[indexPath.row].id,type:categoryDataModelArray[indexPath.row].type,index:indexPath.row)
            }
        }
    }

}

extension RestaurentDetailsVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryDataModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionViewHeader.dequeueReusableCell(withReuseIdentifier: CartCollectionViewCellAndXib.className, for: indexPath) as? CartCollectionViewCellAndXib else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.configureCollection(info: categoryDataModelArray[indexPath.row])
        return cell
    }
    
    

    
    
}

extension RestaurentDetailsVC:UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            return CGSize(width: (UIScreen.main.bounds.size.width/3), height:self.collectionViewHeader.frame.height)

    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView == collectionViewHeader{
//            
//        }
//    }
    
    
}
