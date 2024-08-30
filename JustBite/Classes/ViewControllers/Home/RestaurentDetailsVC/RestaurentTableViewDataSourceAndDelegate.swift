//
//  RestaurentTableViewDataSourceAndDelegate.swift
//  JustBite
//
//  Created by Aman on 13/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension RestaurentDetailsVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScrollScrollView(offset: scrollView.contentOffset.y)
    }
    
}

extension RestaurentDetailsVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            return filterMenuDataArray.count
        }else{
           return menuItemDataModelArray.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblCart.dequeueReusableCell(withIdentifier: CartTableViewCellAndXib.className) as? CartTableViewCellAndXib else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.btnPlusRef.tag = indexPath.row
        cell.btnPlusRef.addTarget(self, action: #selector(customizeTapped), for: .touchUpInside)
        
        cell.btnMinusRef.tag = indexPath.row
        cell.btnMinusRef.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        
        if searchActive{
            cell.configure(item:filterMenuDataArray[indexPath.row])

        }else{
            cell.configure(item:menuItemDataModelArray[indexPath.row])

        }
        cell.btnCustomizeRef.isHidden = true
        
//        cell.btnCustomizeRef.tag = indexPath.row
//        cell.btnCustomizeRef.addTarget(self, action: #selector(customizeTapped), for: .touchUpInside)
//        cell.configure(item:menuItemDataModelArray[indexPath.row])
        return cell
    }
    
    
    
}



// MARK: - Search extensions

extension RestaurentDetailsVC:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            searchActive = false
        }else{
            searchActive = true
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if filterMenuDataArray.count > 0{
            filterMenuDataArray.removeAll()
        }
        if searchBar.text!.isEmpty {
            searchActive = false
        }
        else {
            searchActive = true
            if menuItemDataModelArray.count >= 1 {
                for index in 0...menuItemDataModelArray.count - 1 {
                    if let dictResponse = menuItemDataModelArray[index] as? menuItemDataModel{
                        
                        guard let restName = dictResponse.name as? String else{
                            print("No restName")
                            return
                        }
                       
                        
                        
                        if (restName.lowercased().range(of: searchText.lowercased()) != nil) {
                            filterMenuDataArray.append(dictResponse)
                        }
                    }
                }
            }
        }
        tblCart.reloadData()
    }
}
