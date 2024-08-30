//
//  ProfileTable+TextField.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension ProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//         self.tblHeight?.constant = tblProfile.contentSize.height
//    }
    
    
}

extension ProfileVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
        return dataStore1.count
        }else{
            return dataStore2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoginCell.className, for: indexPath) as? LoginCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.textFieldFloating?.isUserInteractionEnabled = false
        cell.textFieldFloating?.delegate = self
        if indexPath.section == 0{
        cell.configureCellWith(info:dataStore1[indexPath.row])
        }else{
           cell.configureCellWith(info:dataStore2[indexPath.row])
        }
        return cell
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UILabel()
        sectionHeader.backgroundColor = AppColor.whiteColor
        sectionHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        sectionHeader.textColor = AppColor.textColor
        if section == 0{
            sectionHeader.text = ""
        }else{
            sectionHeader.text = "Address"
        }
        return sectionHeader
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 1{
            let footer:AddressFooterForMyProfile = Bundle.main.loadNibNamed("AddressFooterForMyProfile", owner: self, options: nil)!.last! as! AddressFooterForMyProfile
            
//            footer.btnAddressTypeRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
//            footer.btnAddressTypeRef.setTitleColor(AppColor.themeColor, for: .normal)
//            footer.btnAddressTypeRef.setTitle("Address Type", for: .normal)
//
//            footer.btnHomeRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
//            footer.btnHomeRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//            footer.btnHomeRef.setTitle("    Home Address", for: .normal)
//
//            footer.btnOffieceRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
//            footer.btnOffieceRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//            footer.btnOffieceRef.setTitle("    Work/Office Address", for: .normal)
//
            footer.btnEditProfileRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.btnEditProfileRef.setTitleColor(AppColor.themeColor, for: .normal)
            footer.btnEditProfileRef.setTitle("Edit Profile", for: .normal)
            
            footer.btnEditProfileRef.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
            
            GlobalCustomMethods.shared.provideCornarRadius(btnRef: footer.btnEditProfileRef)
            GlobalCustomMethods.shared.provideCustomBorderWithColor(btnRef: footer.btnEditProfileRef, color: AppColor.themeColor)
            
//
//            if address_type == ""{
//                footer.btnHomeRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                footer.btnOffieceRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                footer.btnHomeRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//                footer.btnOffieceRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//            }
//            else if Int(address_type) == 0{
//                footer.btnHomeRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
//                footer.btnOffieceRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                footer.btnHomeRef.setTitleColor(AppColor.themeColor, for: .normal)
//                footer.btnOffieceRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//            }else{
//                footer.btnHomeRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                footer.btnOffieceRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
//                footer.btnHomeRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//                footer.btnOffieceRef.setTitleColor(AppColor.themeColor, for: .normal)
//            }
            return footer
        }else{
                return UIView(frame: CGRect.zero)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1{
             return 100
        }else{
            return 0
        }
    }
    
}


// MARK: - Text Field Delegates

extension ProfileVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndexPath = HHelper.getIndexPathFor(view: textField, tableView: self.tblProfile) else {
            return true
        }
        
        if currentIndexPath.section == 0{
            let lastRowIndex = self.tblProfile.numberOfRows(inSection: 0) - 1
            if currentIndexPath.row != lastRowIndex{
                var nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
                while nextIndexPath.row <= lastRowIndex{
                    if let nextCell = self.tblProfile.cellForRow(at: nextIndexPath) as? LoginCell{
                        self.tblProfile.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
                        nextCell.textFieldFloating?.returnKeyType = .next
                        if nextIndexPath.row == lastRowIndex{
                            nextCell.textFieldFloating?.returnKeyType = .done
                        }
                        nextCell.textFieldFloating?.becomeFirstResponder()
                        break
                        
                    }
                }
                
                textField.resignFirstResponder()
                
            }else{
                textField.resignFirstResponder()
            }
            
        }else{
            let lastRowIndex = self.tblProfile.numberOfRows(inSection: 1) - 1
            if currentIndexPath.row != lastRowIndex{
                var nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 1)
                while nextIndexPath.row <= lastRowIndex{
                    if let nextCell = self.tblProfile.cellForRow(at: nextIndexPath) as? LoginCell{
                        self.tblProfile.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
                        nextCell.textFieldFloating?.returnKeyType = .next
                        if nextIndexPath.row == lastRowIndex{
                            nextCell.textFieldFloating?.returnKeyType = .done
                        }
                        nextCell.textFieldFloating?.becomeFirstResponder()
                        break
                        
                    }
                }
                
                textField.resignFirstResponder()
                
            }else{
                textField.resignFirstResponder()
            }

        }
        
        return true
    }
    
    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        let str = textField.text as String?
//        if let index = HHelper.getIndexPathFor(view: textField, tableView: self.tblViewLogin){
//            if str?.count == 0{
//                self.dataStore[index.row].value = String()
//            }else{
//                self.dataStore[index.row].value = str
//            }
//        }
//    }
//    
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if let _ = HHelper.getIndexPathFor(view: textField, tableView: self.tblViewLogin) {
//            if textField.text!.count > 30 && string != "" {
//                return false
//            }
//        }
//        return true
//    }
    
}
