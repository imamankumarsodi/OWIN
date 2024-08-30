//
//  FogotPasswordCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 06/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields
extension ForgotPasswordVC{
    
    //TODO: Initial Setup
    internal func initialSetup(){
        updateUI()

    }
    
    //TODO: Update UI
   fileprivate func updateUI(){
    ScreeNNameClass.shareScreenInstance.screenName = ForgotPasswordVC.className

        lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringForgotPassword(title: "Forgot Password?", subTitle: "We need your registered email id to send\npassword reset information.", delemit: "\n", sizeTitle: 24, sizeSubtitle: 18, titleColor: AppColor.textColor, SubtitleColor: AppColor.textColor)
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef: self.btnSubmit, title: "Submit")
        hideKeyboardWhenTappedAround()
    
    
    txtEmail?.autocapitalizationType = .words
    //txtFieldLastName?.delegate = self as? UITextFieldDelegate
    textFieldControllerFloatingEmail = MDCTextInputControllerUnderline(textInput: txtEmail)
    textFieldControllerFloatingEmail?.floatingPlaceholderScale = 1.10
    
    txtEmail?.textColor = AppColor.textColor
    textFieldControllerFloatingEmail?.activeColor = AppColor.placeHolderColor
    textFieldControllerFloatingEmail?.normalColor = AppColor.placeHolderColor
    txtEmail?.placeholderLabel.textColor = AppColor.themeColor
    textFieldControllerFloatingEmail?.inlinePlaceholderColor = AppColor.placeHolderColor
    textFieldControllerFloatingEmail?.floatingPlaceholderNormalColor = AppColor.themeColor
    textFieldControllerFloatingEmail?.floatingPlaceholderActiveColor = AppColor.themeColor
    txtEmail?.placeholder = ConstantTexts.forgetEmailPlaceHoler
    txtEmail?.underline?.isHidden = false
    txtEmail?.clearButton.isHidden = false
    txtEmail?.keyboardType = .emailAddress
    
    
        recheckModel()
        
    }
    
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.setupNavigationBarTitle("Forgot Password", leftBarButtonsType: [.back], rightBarButtonsType: [])
        super.transparentNavigation()
        super.hideNavigationBar(false)
        
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: ForgotPasswordVC.className)
        
        
    }
    
    //TODO: Recheck method
    fileprivate func recheckModel(){
        if forgetModel == nil{
            forgetModel = ForgotPasswordModeling()
        }
        setUpDataSource()
    }
    
    //TODO: Data Source method
    fileprivate func setUpDataSource() {
        if let arrDataSource = self.forgetModel?.prepareDataSource() {
            self.dataStore = arrDataSource
        }
        self.registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblForgotPassword.register(nib: LoginCell.className)
    }
    
    
    
    internal func validationSetup(){
        
        var message = ""
        
       if !validation.validateBlankField(txtEmail.text!){
            
            message = ConstantTexts.enterEmail
            
        }else if !validation.validateEmail(txtEmail.text!){
            
            message = ConstantTexts.enterVaidEmail
            
        }
        if message != "" {
            
            _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: AlertStyle.error)
            
        }else{
            forgotPassService()
           // updateUserService()
        }
        
    }
    
    
    
    fileprivate func forgotPassService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let header = ["Content-Type":"application/x-www-form-urlencoded",
                          "Accept":"application/x-www-form-urlencoded"]
            let dataDict = ["email":txtEmail.text!] as! [String:AnyObject]
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURLUndcoded(MacrosForAll.APINAME.resettoken.rawValue, params: dataDict as? [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: .success, buttonTitle: ConstantTexts.Ok, action: { (ok) in
                            if ok{
                               super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                            }
                        })
                    }
                    
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
