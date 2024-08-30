//
//  AddCartCustomMethods.swift
//  JustBite
//
//  Created by Aman on 22/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields
import RealmSwift

//MARK: - Extension Custom methods

extension AddCardVC{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        
        updateUI()
    }
    
    //TODO: UpdateUI method
    
    fileprivate func updateUI(){
        
        ScreeNNameClass.shareScreenInstance.screenName = AddCardVC.className

        
        txtCardName?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingCardName = MDCTextInputControllerUnderline(textInput: txtCardName)
        textFieldControllerFloatingCardName?.floatingPlaceholderScale = 1.10
        
        txtCardName?.textColor = AppColor.textColor
        textFieldControllerFloatingCardName?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingCardName?.normalColor = AppColor.placeHolderColor
        txtCardName?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingCardName?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingCardName?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingCardName?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtCardName?.placeholder = ConstantTexts.nameOnCard
        txtCardName?.underline?.isHidden = false
        txtCardName?.clearButton.isHidden = false
        txtCardName?.keyboardType = .default
        
        

        
        txtCardNumber?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingCardNumber = MDCTextInputControllerUnderline(textInput: txtCardNumber)
        textFieldControllerFloatingCardNumber?.floatingPlaceholderScale = 1.10
        
        txtCardNumber?.textColor = AppColor.textColor
        textFieldControllerFloatingCardNumber?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingCardNumber?.normalColor = AppColor.placeHolderColor
        txtCardNumber?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingCardNumber?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingCardNumber?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingCardNumber?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtCardNumber?.placeholder = ConstantTexts.cardNumber
        txtCardNumber?.underline?.isHidden = false
        txtCardNumber?.clearButton.isHidden = false
        txtCardNumber?.keyboardType = .default
        
        

        
        txtMonth?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingMonth = MDCTextInputControllerUnderline(textInput: txtMonth)
        textFieldControllerFloatingMonth?.floatingPlaceholderScale = 1.10
        
        txtMonth?.textColor = AppColor.textColor
        textFieldControllerFloatingMonth?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingMonth?.normalColor = AppColor.placeHolderColor
        txtMonth?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingMonth?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingMonth?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingMonth?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtMonth?.placeholder = ConstantTexts.montOfExpiry
        txtMonth?.underline?.isHidden = false
        txtMonth?.clearButton.isHidden = false
        txtMonth?.keyboardType = .default
        
        

        
        txtYear?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingYear = MDCTextInputControllerUnderline(textInput: txtYear)
        textFieldControllerFloatingYear?.floatingPlaceholderScale = 1.10
        
        txtYear?.textColor = AppColor.textColor
        textFieldControllerFloatingYear?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingYear?.normalColor = AppColor.placeHolderColor
        txtYear?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingYear?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingYear?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingYear?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtYear?.placeholder = ConstantTexts.yearEx
        txtYear?.underline?.isHidden = false
        txtYear?.clearButton.isHidden = false
        txtYear?.keyboardType = .default
        

        
        txtCVV?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingCVV = MDCTextInputControllerUnderline(textInput: txtCVV)
        textFieldControllerFloatingCVV?.floatingPlaceholderScale = 1.10
        
        txtCVV?.textColor = AppColor.textColor
        textFieldControllerFloatingCVV?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingCVV?.normalColor = AppColor.placeHolderColor
        txtCVV?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingCVV?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingCVV?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingCVV?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtCVV?.placeholder = ConstantTexts.cvvNumber
        txtCVV?.underline?.isHidden = false
        txtCVV?.clearButton.isHidden = false
        txtCVV?.keyboardType = .default
        
        
        
        hideKeyboardWhenTappedAround()
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 20)
        lblHeader.textColor = AppColor.textColor
        lblHeader.text = "Enter Card Details"
        
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.mainView, radius: 5)
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnSubmit, title: "SAVE CARD")
        
        
        
        
        

        
      //  recheckModel()
    }
    
    
    //TODO: Naigation Setup
    internal func navigationSetUP(){
        preferredStatusBarStyle
        super.transparentNavigation()
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: LoginVC.className)
        super.hideNavigationBar(true)
    }
    
    
    //TODO: Recheck method
    fileprivate func recheckModel(){
        if loginModel == nil{
            loginModel = AddCardVM()
        }
       // setUpDataSource()
    }
    
    //TODO: Data Source method
    fileprivate func setUpDataSource() {
        if let arrDataSource = self.loginModel?.prepareDataSource() {
            self.dataStore = arrDataSource
        }
        self.registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        
        self.tblLogin.register(nib: LoginCell.className)
        
    }
    
    
    internal func validationSetUp(){
        
        var message = ""
        let month = Int(txtMonth.text!) ?? 0
        let year = Int(txtYear.text!) ?? 0
        if !validation.validateBlankField(txtCardName.text!){
            
            message = ConstantTexts.cardNameAlert
            
        }else if (txtCardName.text!.count < 2 ){
            
            message = ConstantTexts.cardNameValidAlert
            
        }else if !validation.validateBlankField(txtCardNumber.text!){
            message = ConstantTexts.cardNumberAlert
        }else if (txtCardNumber.text!.count < 10){
            message = ConstantTexts.correctCardNumberAlert
        }else if !validation.validateBlankField(txtMonth.text!){
            message = ConstantTexts.enterExpireMonth
        }else if month == 0 || month > 12{
            message = ConstantTexts.enterExpireValidMonth
        }else if !validation.validateBlankField(txtYear.text!){
            message = ConstantTexts.enterExpireYear
        }else if year == 0{
            message = ConstantTexts.enterExpireValidYear
        }
        else if !validation.validateBlankField(txtCVV.text!){
            message = ConstantTexts.enterCVVnumber
        }
        else if (txtCVV.text!.count < 3){
            message = ConstantTexts.enterCorrectCVVnumber
        }
        if message != "" {
            
            _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: AlertStyle.error)
            
        }else{
            
            updateUserService()
        }
        
    }
    
    
    
    fileprivate func updateUserService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
            
           
            
            
            let passDict = ["card_name":txtCardName.text!,
                            "card_number":txtCardNumber.text!,
                            "card_exp_month":txtMonth.text!,
                            "card_exp_year":txtYear.text!,
                            "card_cvv":txtCVV.text!] as [String:AnyObject]
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.cardsave.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    
                    if let message = responseJASON["message"].stringValue as? String{
                       _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
                    }
                    
                    if self.isComing == "PAYM"{
                        self.objMode?.callApi()
                    }else{
                        self.obj?.callApi()
                    }
                    
                     self.dismiss(animated: true, completion: nil)
                    
                }else{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                    
                }
                
            }, failure: { (error) in
                self.macroObj.hideLoader(view: self.view)
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    
    
}
