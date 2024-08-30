//
//  MenuItemTableViewDataSourceAndDelegate.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit


extension MenuItemsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        protObj?.backDataToDetilsReload(index1: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
}

extension MenuItemsVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblAddOns.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.className, for: indexPath) as? MenuItemTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.configure(info:categoryDataModelArray[indexPath.row])
        return cell
    }
    
    
}
