  //
  //  TopUpTableView.swift
  //  JustBite
  //
  //  Created by Aman on 16/05/19.
  //  Copyright © 2019 Mobulous. All rights reserved.
  //
  
  import Foundation
  import UIKit
  
  
  extension TopUpOffersVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
  }
  
  extension TopUpOffersVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblAddOns.dequeueReusableCell(withIdentifier: TopUpOfferTableViewCell.className, for: indexPath) as? TopUpOfferTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.lblDetails.text = dataStore[indexPath.row].description
        
        if dataStore[indexPath.row].isSelected {
            cell.imgSelected.image = #imageLiteral(resourceName: "radio_button")
        }
        else
        {
            cell.imgSelected.image = #imageLiteral(resourceName: "un_salected_rb")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        for index in 0..<dataStore.count {
            if index == indexPath.row {
              dataStore[indexPath.row].isSelected =  !dataStore[indexPath.row].isSelected
                if dataStore[indexPath.row].isSelected{
                    topup_id = String(dataStore[indexPath.row].id)
                }else{
                    topup_id = String()
                }
            } else {
                dataStore[index].isSelected = false
            }
        }
        
        
        tblAddOns.reloadData()
        
    }
    
  }
