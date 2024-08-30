//
//  RestaurentTableViewDataSourceDelegateExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit


extension RestaurentInfoVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        header.lblDetails.numberOfLines = 0
        header.lblDetails.lineBreakMode = NSLineBreakMode.byWordWrapping
        header.lblDetails.sizeToFit()
        return 160.5 + header.lblDetails.frame.height
    }
    

}

extension RestaurentInfoVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewDataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblAddOns.dequeueReusableCell(withIdentifier: RestaurentInfoTableViewCell.className, for: indexPath) as? RestaurentInfoTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.configure(info:reviewDataModelArray[indexPath.row])
        return cell
    }
    
}



