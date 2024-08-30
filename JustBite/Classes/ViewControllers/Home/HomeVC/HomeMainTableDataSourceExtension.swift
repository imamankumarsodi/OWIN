//
//  HomeMainTableDataSourceExtension.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else{
          return 400
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 300
        }else{
            return 400
        }
        
    }
    
  
    
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeListModelArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        guard let cell = tblViewHome.dequeueReusableCell(withIdentifier: HomeMainTableViewCell.className, for: indexPath) as? HomeMainTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.index = indexPath.row
        if indexPath.row == 0{
            cell.lblTitle.text = "Available Offers"
            cell.lblTitle.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
            
        }else if indexPath.row == 1{
            cell.lblTitle.text = "Top Rated Restaurants"
            cell.lblTitle.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        }else{
            cell.lblTitle.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
            cell.lblTitle.text = "Near-by Restaurants"
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
        }
        
        
        
        if homeListModelArray[indexPath.row].HomeListingArr.count > 0{
            macroObj.hideLoaderEmpty(view: cell.collectionView)
        
            cell.collectionView.isHidden = false
            cell.restaurentDataModelForHomeItem = homeListModelArray[indexPath.row].HomeListingArr
            cell.superVC = self
            cell.btnRestRef.isUserInteractionEnabled = true
            cell.btnRestRef.tag = indexPath.row
            cell.btnRestRef.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
        }else{
            cell.btnRestRef.isHidden = true
            cell.lblTitle.isHidden = true
            cell.lblViewAll.isHidden = true
            
            cell.btnRestRef.isUserInteractionEnabled = false
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            cell.collectionView.isHidden = true
            macroObj.showLoaderEmpty(view: cell)
        }
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.reloadData()
        return cell
    }
    
}
