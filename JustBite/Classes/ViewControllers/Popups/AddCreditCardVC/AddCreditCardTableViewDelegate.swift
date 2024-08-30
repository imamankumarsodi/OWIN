//
//  AddCreditCardTableViewDelegate.swift
//  JustBite
//
//  Created by Aman on 22/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
extension AddCardVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension AddCardVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoginCell.className, for: indexPath) as? LoginCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.textFieldFloating?.delegate = self
        cell.configureCellWith(info:dataStore[indexPath.row])
        cell.imgViewIcon.isHidden = true
        return cell
    }
    
}


// MARK: - Text Field Delegates

extension AddCardVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndexPath = HHelper.getIndexPathFor(view: textField, tableView: self.tblLogin) else {
            return true
        }
        
        let lastRowIndex = self.tblLogin.numberOfRows(inSection: 0) - 1
        if currentIndexPath.row != lastRowIndex{
            var nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            while nextIndexPath.row <= lastRowIndex{
                if let nextCell = self.tblLogin.cellForRow(at: nextIndexPath) as? LoginCell{
                    self.tblLogin.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
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
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let str = textField.text as String?
        if let index = HHelper.getIndexPathFor(view: textField, tableView: self.tblLogin){
            if str?.count == 0{
                self.dataStore[index.row].value = String()
            }else{
                self.dataStore[index.row].value = str
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let _ = HHelper.getIndexPathFor(view: textField, tableView: self.tblLogin) {
            if textField.text!.count > 50 && string != "" {
                return false
            }
        }
        return true
    }
    
}