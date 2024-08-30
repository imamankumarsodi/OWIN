//
//  EditAddressCustomMethods.swift
//  JustBite
//
//  Created by Aman on 22/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields

//MARK: - Extension Custom methods

extension EditAddressPopUPVC{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        
        updateUI()
    }
    
    //TODO: UpdateUI method
    
    fileprivate func updateUI(){
        ScreeNNameClass.shareScreenInstance.screenName = EditAddressPopUPVC.className
        hideKeyboardWhenTappedAround()
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 20)
        lblHeader.textColor = AppColor.textColor
        lblHeader.text = "Address"
        
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.mainView, radius: 5)
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnSubmit, title: "Done")

        
        txtArea?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingArea = MDCTextInputControllerUnderline(textInput: txtArea)
        textFieldControllerFloatingArea?.floatingPlaceholderScale = 1.10
        
        txtArea?.textColor = AppColor.textColor
        textFieldControllerFloatingArea?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingArea?.normalColor = AppColor.placeHolderColor
        txtArea?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingArea?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingArea?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingArea?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtArea?.placeholder = ConstantTexts.area
        txtArea?.underline?.isHidden = false
        txtArea?.clearButton.isHidden = false
        txtArea?.keyboardType = .default
        
        txtHouse?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingHouse = MDCTextInputControllerUnderline(textInput: txtHouse)
        textFieldControllerFloatingHouse?.floatingPlaceholderScale = 1.10
        
        txtHouse?.textColor = AppColor.textColor
        textFieldControllerFloatingHouse?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingHouse?.normalColor = AppColor.placeHolderColor
        txtHouse?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingHouse?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingHouse?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingHouse?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtHouse?.placeholder = ConstantTexts.houseFlat
        txtHouse?.underline?.isHidden = false
        txtHouse?.clearButton.isHidden = false
        txtHouse?.keyboardType = .default
        
        txtPin?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingPin = MDCTextInputControllerUnderline(textInput: txtPin)
        textFieldControllerFloatingPin?.floatingPlaceholderScale = 1.10
        
        txtPin?.textColor = AppColor.textColor
        textFieldControllerFloatingPin?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingPin?.normalColor = AppColor.placeHolderColor
        txtPin?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingPin?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingPin?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingPin?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtPin?.placeholder = ConstantTexts.pinCode
        txtPin?.underline?.isHidden = false
        txtPin?.clearButton.isHidden = false
        txtPin?.keyboardType = .default
        
        
        txtLM?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingLM = MDCTextInputControllerUnderline(textInput: txtLM)
        textFieldControllerFloatingLM?.floatingPlaceholderScale = 1.10
        
        txtLM?.textColor = AppColor.textColor
        textFieldControllerFloatingLM?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingLM?.normalColor = AppColor.placeHolderColor
        txtLM?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingLM?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingLM?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingLM?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtLM?.placeholder = ConstantTexts.landmark
        txtLM?.underline?.isHidden = false
        txtLM?.clearButton.isHidden = false
        txtLM?.keyboardType = .default
//
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
//        lblFooter.isUserInteractionEnabled = true
//        lblFooter.addGestureRecognizer(tap)
        
        recheckModel()
    }
    
    
    //TODO: Naigation Setup
    internal func navigationSetUP(){
        preferredStatusBarStyle
        super.transparentNavigation()
        super.addColorToNavigationBarAndSafeArea(color:gradientLayer, className: LoginVC.className)
        super.hideNavigationBar(true)
    }
    
    
    //TODO: Recheck method
    fileprivate func recheckModel(){
        if loginModel == nil{
            loginModel = EditAddressVM()
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
        self.tblLogin.register(nib: LoginCell.className)
    }
}
