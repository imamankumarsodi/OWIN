//
//  RatingAndReviewTableViewExtension.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit


extension RatingAndReviewsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  
}

extension RatingAndReviewsVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewDataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblAddOns.dequeueReusableCell(withIdentifier: RestaurentInfoTableViewCell.className, for: indexPath) as? RestaurentInfoTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.configure(info: reviewDataModelArray[indexPath.row])
        
        return cell
    }
    
    
}
