//
//  SubMenuListingTableViewExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit


extension SubMenuListingVC:UITableViewDelegate{
    
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if customizeDataModelArray[indexPath.section].type != 1{
            customizeDataModelArray[indexPath.section].addons[indexPath.row].isSelected = !customizeDataModelArray[indexPath.section].addons[indexPath.row].isSelected
           
        }else{
            for index in 0..<customizeDataModelArray[indexPath.section].addons.count{
                if index == indexPath.row{
                    customizeDataModelArray[indexPath.section].addons[index].isSelected = !customizeDataModelArray[indexPath.section].addons[index].isSelected
                }else{
                    customizeDataModelArray[indexPath.section].addons[index].isSelected = false
                }
            }
            
        }
        
        assignValueForSum()
        tblAddOns.reloadData()
    }
}

extension SubMenuListingVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return customizeDataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customizeDataModelArray[section].addons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblAddOns.dequeueReusableCell(withIdentifier: ChooseYorTasteTableViewCell.className, for: indexPath) as? ChooseYorTasteTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.configure(info:customizeDataModelArray[indexPath.section].addons[indexPath.row], type: customizeDataModelArray[indexPath.section].type)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let Header:CartHeaderView = Bundle.main.loadNibNamed("CartHeaderView", owner: self, options: nil)!.first! as! CartHeaderView
        var subTitle = String()
        if customizeDataModelArray[section].type == 1{
            subTitle = "Please select any one option."
        }else{
            subTitle = "You can choose multiple options."
        }
        
        Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: customizeDataModelArray[section].itemHeading, subTitle: subTitle, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
        return Header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
}
