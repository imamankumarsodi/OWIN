//
//  SettingTableView.swift
//  JustBite
//
//  Created by Aman on 18/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}

extension SettingsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == self.selectedSection {
            return 1
        }else {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangePasswordCell.className, for: indexPath) as? ChangePasswordCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        //cell.textFieldFloating?.delegate = self
        //cell.configureCellWith(info:dataStore[indexPath.row])
        cell.btnOldPasswordRef.tag = indexPath.row
        cell.btnNewPasswordRef.tag = indexPath.row
        cell.btnConfirmPasswordRef.tag = indexPath.row
        cell.btnOldPasswordRef.addTarget(self, action: #selector(btnOldPasswordTapped), for: .touchUpInside)
        cell.btnNewPasswordRef.addTarget(self, action: #selector(btnNewPasswordTapped), for: .touchUpInside)
        
        cell.btnConfirmPasswordRef.addTarget(self, action: #selector(btnConfirmPasswordTapped), for: .touchUpInside)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let header:SettingsHeader = Bundle.main.loadNibNamed(SettingsHeader.className, owner: self, options: nil)!.first! as! SettingsHeader
        
        header.btnTap.tag = section
        header.btnTap.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
        
        
     if section == 0{
            header.img.image = #imageLiteral(resourceName: "drop_dwn")
            header.btnTap.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            header.btnTap.backgroundColor = UIColor.clear
            header.btnTap.setTitleColor(AppColor.themeColor, for: .normal)
            header.btnTap.setTitle("Change Password", for: .normal)
          
            
            return header
        }else{
            header.img.image = #imageLiteral(resourceName: "logout")
            header.btnTap.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            header.btnTap.backgroundColor = UIColor.clear
            header.btnTap.setTitleColor(AppColor.subtitleColor, for: .normal)
            header.btnTap.setTitle("Logout", for: .normal)
            
           
            
            return header
        }
        
       
            
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
       
            if section == self.selectedSection {
                return 60
            }
            return 60

        
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == self.selectedSection
        {
            let footer:SettingFooter = Bundle.main.loadNibNamed(SettingFooter.className, owner: self, options: nil)!.last! as! SettingFooter
           GlobalCustomMethods.shared.setupSubmitBtn(btnRef:footer.btnSubmitTapped, title: "Save")
            footer.btnSubmitTapped.addTarget(self, action: #selector(changePassowrd), for: .touchUpInside)
            return footer
        }else {
            return UIView(frame: CGRect.zero)
        }
        
    }
    
    
    @objc func changePassowrd(_ sender: UIButton){
        let index = IndexPath(row: 0, section: 1)
        if let cell = tblSetting.cellForRow(at: index) as? ChangePasswordCell{
            validationSetup(cell:cell)
        }
    }
    
    
    internal func validationSetup(cell:ChangePasswordCell){
        
        var message = ""
        
        if !validation.validateBlankField(cell.textFieldOldPasswordFloating?.text!){
            
            message = ConstantTexts.password
            
        }else if ((cell.textFieldOldPasswordFloating?.text!.count)! < 6 ){
            
            message = ConstantTexts.validPassword
            
        }else if !validation.validateBlankField(cell.textFieldNewPasswordFloating?.text!){
            
            message = ConstantTexts.newPasswordAlert
            
        }else if ((cell.textFieldNewPasswordFloating?.text!.count)! < 6 ){
            
            message = ConstantTexts.validewPassword
            
        }else if !validation.validateBlankField(cell.textFieldConfirmPasswordFloating?.text!){
            
            message = ConstantTexts.reTypePassword
            
        }else if ((cell.textFieldConfirmPasswordFloating?.text!.count)! < 6 ){
            
            message = ConstantTexts.validewPassword
            
        }
        
        if cell.textFieldNewPasswordFloating?.text != cell.textFieldConfirmPasswordFloating?.text{
           message = ConstantTexts.retypeConfirmPassword
        }
        
        if message != "" {
            
            _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: AlertStyle.error)
            
        }else{
            
            changePassword(oldPass:(cell.textFieldOldPasswordFloating?.text!)!,newPass:(cell.textFieldConfirmPasswordFloating?.text!)!)
           // loginService()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.selectedSection {
            return 100
        }else {
            return 1
        }
    }
    
}


// MARK: - Text Field Delegates

extension SettingsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndexPath = HHelper.getIndexPathFor(view: textField, tableView: self.tblSetting) else {
            return true
        }
        
        let lastRowIndex = self.tblSetting.numberOfRows(inSection: 0) - 1
        if currentIndexPath.row != lastRowIndex{
            var nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            while nextIndexPath.row <= lastRowIndex{
                if let nextCell = self.tblSetting.cellForRow(at: nextIndexPath) as? LoginCell{
                    self.tblSetting.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
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
        if let index = HHelper.getIndexPathFor(view: textField, tableView: self.tblSetting){
            if str?.count == 0{
                self.dataStore[index.row].value = String()
            }else{
                self.dataStore[index.row].value = str
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let _ = HHelper.getIndexPathFor(view: textField, tableView: self.tblSetting) {
            if textField.text!.count > 50 && string != "" {
                return false
            }
        }
        return true
    }
    
    
    
    internal func changePassword(oldPass:String,newPass:String){
        self.macroObj.showLoader(view: self.view)
        
        
        var token_type = String()
        var access_token = String()
        
        if let userInfo = realm.objects(SignupDataModel.self).first{
            token_type = userInfo.token_type
            access_token = userInfo.access_token
        }
        
        let header = ["Authorization":"\(token_type) \(access_token)",
            "Accept":"application/json"]
        
        let passDict = ["old_password":oldPass,
                        "new_password":newPass] as [String:AnyObject]
        
        print(passDict)
        print(header)
        
        alamoFireObj.postRequestURLFormData1(MacrosForAll.APINAME.userpassword.rawValue, params: passDict, headers: header, success: { (responseJASON) in
            print(responseJASON)
            if responseJASON["status"].string == "true"{
                 self.macroObj.hideLoader(view: self.view)
                if let message = responseJASON["message"].string{
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
                }
                
            }else{
                self.macroObj.hideLoader(view: self.view)
                if let message = responseJASON["message"].string{
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                }
                
            }
            
        }) { (error) in
            self.macroObj.hideLoader(view: self.view)
            print(error.localizedDescription)
            print(error)
        }
        
    }
    
    
}
