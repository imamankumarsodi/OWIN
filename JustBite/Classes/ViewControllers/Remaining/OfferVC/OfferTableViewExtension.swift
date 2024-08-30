//
//  OfferTableViewExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit


extension OfferVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
        vc.id = String(favModelArray[indexPath.row].restorent_id)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
}

extension OfferVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tblOrders.dequeueReusableCell(withIdentifier: OfferTableViewCellAndXib.className, for: indexPath) as? OfferTableViewCellAndXib else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        if isCominng == "Cart"{
            
         
        }
        else{
                cell.configureWith(info: favModelArray[indexPath.row])
        }
    
        return cell
    }
    
    
}
