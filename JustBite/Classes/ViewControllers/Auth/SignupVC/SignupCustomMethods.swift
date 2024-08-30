//
//  SignupCustomMethods.swift
//  JustBite
//
//  Created by Aman on 06/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields
import Firebase

extension SignupVC{
    internal func initialSetup(){
        
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        //CODE FOR MVC---->START
        ScreeNNameClass.shareScreenInstance.screenName = SignupVC.className
        txtFieldFirstName?.autocapitalizationType = .words
        // txtFieldFirstName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingFirstName = MDCTextInputControllerUnderline(textInput: txtFieldFirstName)
        textFieldControllerFloatingFirstName?.floatingPlaceholderScale = 1.10
        
        txtFieldFirstName?.textColor = AppColor.textColor
        textFieldControllerFloatingFirstName?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingFirstName?.normalColor = AppColor.placeHolderColor
        txtFieldFirstName?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingFirstName?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingFirstName?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingFirstName?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtFieldFirstName?.placeholder = ConstantTexts.nameFirst
        txtFieldFirstName?.underline?.isHidden = false
        txtFieldFirstName?.clearButton.isHidden = false
        txtFieldFirstName?.keyboardType = .default
        
        
        
        txtFieldLastName?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingLastName = MDCTextInputControllerUnderline(textInput: txtFieldLastName)
        textFieldControllerFloatingLastName?.floatingPlaceholderScale = 1.10
        
        txtFieldLastName?.textColor = AppColor.textColor
        textFieldControllerFloatingLastName?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingLastName?.normalColor = AppColor.placeHolderColor
        txtFieldLastName?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingLastName?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingLastName?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingLastName?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtFieldLastName?.placeholder = ConstantTexts.nameLast
        txtFieldLastName?.underline?.isHidden = false
        txtFieldLastName?.clearButton.isHidden = false
        txtFieldLastName?.keyboardType = .default
        
        
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
        
        
        txtCountryCode?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingCountryCode = MDCTextInputControllerUnderline(textInput: txtCountryCode)
        textFieldControllerFloatingCountryCode?.floatingPlaceholderScale = 1.10
        
        txtCountryCode?.textColor = AppColor.textColor
        textFieldControllerFloatingCountryCode?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingCountryCode?.normalColor = AppColor.placeHolderColor
        txtCountryCode?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingCountryCode?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingCountryCode?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingCountryCode?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtCountryCode?.placeholder = ConstantTexts.countryCode
        txtCountryCode?.underline?.isHidden = false
        txtCountryCode?.clearButton.isHidden = false
        txtCountryCode?.keyboardType = .phonePad
        
        
        txtPhoneNumber?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingPhoneNumber = MDCTextInputControllerUnderline(textInput: txtPhoneNumber)
        textFieldControllerFloatingPhoneNumber?.floatingPlaceholderScale = 1.10
        
        txtPhoneNumber?.textColor = AppColor.textColor
        textFieldControllerFloatingPhoneNumber?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingPhoneNumber?.normalColor = AppColor.placeHolderColor
        txtPhoneNumber?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingPhoneNumber?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingPhoneNumber?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingPhoneNumber?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtPhoneNumber?.placeholder = ConstantTexts.mobileNumberPlaceHolder
        txtPhoneNumber?.underline?.isHidden = false
        txtPhoneNumber?.clearButton.isHidden = false
        txtPhoneNumber?.keyboardType = .phonePad
        
        
        txtAddress?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingAddress = MDCTextInputControllerUnderline(textInput: txtAddress)
        textFieldControllerFloatingAddress?.floatingPlaceholderScale = 1.10
        
        txtAddress?.textColor = AppColor.textColor
        textFieldControllerFloatingAddress?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingAddress?.normalColor = AppColor.placeHolderColor
        txtAddress?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingAddress?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingAddress?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingAddress?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtAddress?.placeholder = ConstantTexts.address
        txtAddress?.underline?.isHidden = false
        txtAddress?.clearButton.isHidden = false
        txtAddress?.keyboardType = .default
        
        txtPassword?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingPassword = MDCTextInputControllerUnderline(textInput: txtPassword)
        textFieldControllerFloatingPassword?.floatingPlaceholderScale = 1.10
        
        txtPassword?.textColor = AppColor.textColor
        textFieldControllerFloatingPassword?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingPassword?.normalColor = AppColor.placeHolderColor
        txtPassword?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtPassword?.placeholder = ConstantTexts.passwordPlaceHolder
        txtPassword?.underline?.isHidden = false
        txtPassword?.clearButton.isHidden = false
        txtPassword?.keyboardType = .default
        
        
        
        txtConfirmPassword?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingConfirmPassword = MDCTextInputControllerUnderline(textInput: txtConfirmPassword)
        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderScale = 1.10
        
        txtConfirmPassword?.textColor = AppColor.textColor
        textFieldControllerFloatingConfirmPassword?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingConfirmPassword?.normalColor = AppColor.placeHolderColor
        txtConfirmPassword?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingConfirmPassword?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingConfirmPassword?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtConfirmPassword?.placeholder = ConstantTexts.confirmPasswordPlaceHolder
        txtConfirmPassword?.underline?.isHidden = false
        txtConfirmPassword?.clearButton.isHidden = false
        txtConfirmPassword?.keyboardType = .default
        
        AccessCurrentLocationuser()
        
        //CODE FOR MVC---->END
        
        
        hideKeyboardWhenTappedAround()
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnLoginRef, title: "SIGN UP")
        recheckModel()
        
        
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
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
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: SignupVC.className)
        super.setupNavigationBarTitle("SignUp", leftBarButtonsType: [.back], rightBarButtonsType: [])
    }
    
    
    
    //TODO: Recheck method
    fileprivate func recheckModel(){
        if loginModel == nil{
            loginModel = SignUpVM()
        }
        setUpDataSource()
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
        
        self.tblViewLogin.registerMultiple(nibs: [LoginCell.className,SignUpTableViewCell.className])
        
    }
    
    
    //TODO: ValidationSetup
    
    internal func validationSetup(){
        
        var message = ""
        
        if !validation.validateBlankField(txtFieldFirstName.text!){
            
            message = ConstantTexts.enterFirstName
            
        }else if (txtFieldFirstName.text!.count < 2 ){
            
            message = ConstantTexts.enterValidFirstName
            
        }else if !validation.validateBlankField(txtFieldLastName.text!){
            
            message = ConstantTexts.enterLastName
            
        }else if (txtFieldLastName.text!.count < 2 ){
            
            message = ConstantTexts.enterValidLastName
            
        }else if !validation.validateBlankField(txtEmail.text!){
            
            message = ConstantTexts.enterEmail
            
        }else if !validation.validateEmail(txtEmail.text!){
            
            message = ConstantTexts.enterVaidEmail
            
        }else if !validation.validateBlankField(txtCountryCode.text!){
            
            message = ConstantTexts.counrtyCodeAlert
            
        }else if !validation.validateBlankField(txtPhoneNumber.text!){
            
            message = ConstantTexts.enterMobile
            
        }else if !validation.validateBlankField(txtAddress.text!){
            
            message = ConstantTexts.enterAddress
            
        }else if !validation.validateBlankField(txtPassword.text!){
            
            message = ConstantTexts.password
            
        }else if (txtPassword.text!.count < 6 ){
            message = ConstantTexts.validPassword
            
        }else if !validation.validateBlankField(txtConfirmPassword.text!){
            
            message = ConstantTexts.confirmPassword
            
        }else if (txtConfirmPassword.text!.count < 6 ){
            
            message = ConstantTexts.validConfirmPassword
            
        }else if txtPassword.text! != txtConfirmPassword.text!{
            
            message = ConstantTexts.retypePasswordConfirmPassword
            
        }
        
        
        if message != "" {
            
            _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: AlertStyle.error)
            
        }else{
            
           checkEmail()
        }
      
    }
    
    
}


//MARK: - Extensions for web services

extension SignupVC{
    fileprivate func checkEmail(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let passDict = ["email":txtEmail.text!,
                            "phone":txtPhoneNumber.text!]
            
            let header = ["Content-Type":"application/json",
                          "Accept":"application/x-www-form-urlencoded"]
            
            print(header)
            print(passDict)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.beforesignupcheck.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    
                    if let message = responseJASON["message"].string{
                        if message == "Already exists"{
                              _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                        }else{
                           self.sendOTP()
                        }
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
        
    internal func sendOTP(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let phoneNumber = "\(txtCountryCode.text!)\(txtPhoneNumber.text!)"
            print(phoneNumber)
            macroObj.showLoader(view: view)
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    self.macroObj.hideLoader(view: self.view)
                    print(error)
                    print(error.localizedDescription)
                    return
                }else{
                    // Sign in using the verificationID and the code sent to the user
                    // ...
                    self.macroObj.hideLoader(view: self.view)
                    let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: VarificationVC.className) as! VarificationVC
                    vc.countryCode = self.txtCountryCode.text!
                    vc.phoneNumber = self.txtPhoneNumber.text!
                    vc.varificationCode = verificationID!
                    vc.dataDict = self.dataOnSignUp()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)

        }
    }
    
    //TODO: Data on SignUp
    
    func dataOnSignUp()->[String:AnyObject]{
        
        let devicetoken = UserDefaults.standard.value(forKey: "devicetoken") as? String ?? "Simulaterwalatokenbb55d44bfc4492bd33aac79afeaee474e92c12138e18b021e2326"
        let dataDict = ["first_name":txtFieldFirstName.text!,
                        "last_name":txtFieldLastName.text!,
                        "email":txtEmail.text!,
                        "country_code":txtCountryCode.text!,
                        "phone":txtPhoneNumber.text!,
                        "password":txtConfirmPassword.text!,
                        "password_confirmation":txtConfirmPassword.text!,
                        "address":txtAddress.text!,
                        "device_type":"ios",
                        "device_token":devicetoken,
                        "latitude":self.lat,
                        "longitude":self.long] as [String:AnyObject]
        return dataDict
    }
    
    
}



