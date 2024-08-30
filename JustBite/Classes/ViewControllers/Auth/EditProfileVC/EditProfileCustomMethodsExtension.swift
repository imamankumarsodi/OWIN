//
//  EditProfileCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields
import RealmSwift

extension EditProfileVC{
    internal func initialSetup(){
        
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
         ScreeNNameClass.shareScreenInstance.screenName = EditProfileVC.className
        hideKeyboardWhenTappedAround()
        self.tblProfile.backgroundColor = AppColor.whiteColor
        
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
        
        
        lblAddress.backgroundColor = AppColor.whiteColor
        lblAddress.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        lblAddress.textColor = AppColor.textColor
        lblAddress.text = "Address"
        
        
        
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
        txtArea?.placeholder = ConstantTexts.location
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
        
        txtBuilding?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingBuilding = MDCTextInputControllerUnderline(textInput: txtBuilding)
        textFieldControllerFloatingBuilding?.floatingPlaceholderScale = 1.10
        
        txtBuilding?.textColor = AppColor.textColor
        textFieldControllerFloatingBuilding?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingBuilding?.normalColor = AppColor.placeHolderColor
        txtBuilding?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingBuilding?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingBuilding?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingBuilding?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtBuilding?.placeholder = ConstantTexts.building
        txtBuilding?.underline?.isHidden = false
        txtBuilding?.clearButton.isHidden = false
        txtBuilding?.keyboardType = .default

        txtFloor?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingtxtFloor = MDCTextInputControllerUnderline(textInput: txtFloor)
        textFieldControllerFloatingtxtFloor?.floatingPlaceholderScale = 1.10
        
        txtFloor?.textColor = AppColor.textColor
        textFieldControllerFloatingtxtFloor?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingtxtFloor?.normalColor = AppColor.placeHolderColor
        txtFloor?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingtxtFloor?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingtxtFloor?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingtxtFloor?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtFloor?.placeholder = ConstantTexts.floor
        txtFloor?.underline?.isHidden = false
        txtFloor?.clearButton.isHidden = false
        txtFloor?.keyboardType = .default
        
        txtAppartment?.autocapitalizationType = .words
        //txtFieldLastName?.delegate = self as? UITextFieldDelegate
        textFieldControllerFloatingtxtAppartment = MDCTextInputControllerUnderline(textInput:txtAppartment)
        textFieldControllerFloatingtxtAppartment?.floatingPlaceholderScale = 1.10
        
        txtAppartment?.textColor = AppColor.textColor
        textFieldControllerFloatingtxtAppartment?.activeColor = AppColor.placeHolderColor
        textFieldControllerFloatingtxtAppartment?.normalColor = AppColor.placeHolderColor
        txtAppartment?.placeholderLabel.textColor = AppColor.themeColor
        textFieldControllerFloatingtxtAppartment?.inlinePlaceholderColor = AppColor.placeHolderColor
        textFieldControllerFloatingtxtAppartment?.floatingPlaceholderNormalColor = AppColor.themeColor
        textFieldControllerFloatingtxtAppartment?.floatingPlaceholderActiveColor = AppColor.themeColor
        txtAppartment?.placeholder = ConstantTexts.appartmentNo
        txtAppartment?.underline?.isHidden = false
        txtAppartment?.clearButton.isHidden = false
        txtAppartment?.keyboardType = .default
        
        
//        btnAddressTypeRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
//        btnAddressTypeRef.setTitleColor(AppColor.themeColor, for: .normal)
//        btnAddressTypeRef.setTitle("Address Type", for: .normal)
//
//        btnHomeRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
//        btnHomeRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//        btnHomeRef.setTitle("    Home Address", for: .normal)
//
//        btnOffieceRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
//        btnOffieceRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//        btnOffieceRef.setTitle("    Work/Office Address", for: .normal)
//
//
//
        
        btnEditProfileRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        btnEditProfileRef.setTitleColor(AppColor.whiteColor, for: .normal)
        btnEditProfileRef.setTitle("Save", for: .normal)
        
        
        GlobalCustomMethods.shared.provideCornarRadius(btnRef: btnEditProfileRef)
      //  GlobalCustomMethods.shared.provideCustomBorderWithColor(btnRef: btnEditProfileRef, color: AppColor.themeColor)
        btnEditProfileRef.backgroundColor = AppColor.stepperColor
        
        checkAutoLogin()
        
        AccessCurrentLocationuser()
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
          super.setupNavigationBarTitle("Edit Profile", leftBarButtonsType: [.back], rightBarButtonsType: [])
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: EditProfileVC.className)
    }
    
    
    
    //TODO: Recheck method
    fileprivate func recheckModel(){
        if profileModel == nil{
            profileModel = EditProfileVM()
        }
        setUpDataSource()
    }
    
    //TODO: Data Source method
    fileprivate func setUpDataSource() {
        if let arrDataSource = self.profileModel?.prepareDataSource() {
            self.dataStore1 = arrDataSource.0
            self.dataStore2 = arrDataSource.1
        }
        self.registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        
        self.tblProfile.registerMultiple(nibs: [LoginCell.className,SignUpTableViewCell.className])
        
    }
    
    fileprivate func checkAutoLogin(){
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            self.txtFieldFirstName.text = userInfo.first_name
            self.txtFieldLastName.text = userInfo.last_name
            self.txtEmail.text = userInfo.email_id
            self.txtCountryCode.text = userInfo.country_code
            self.txtPhoneNumber.text = userInfo.phone
            self.txtArea.text = userInfo.address
            
            if userInfo.address_type == "0"{
                self.txtHouse.text = ConstantTexts.homeAddress
               
            }else{
                self.txtHouse.text = ConstantTexts.officeAddress
              
            }
            
            self.txtPin.text = userInfo.street
            self.txtLM.text = userInfo.landmark
            self.txtBuilding.text = userInfo.building
            self.txtFloor.text = userInfo.floor
            self.txtAppartment.text = userInfo.apartment
//
//            if address_type == ""{
//                btnHomeRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                btnOffieceRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                btnHomeRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//                btnOffieceRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//            }
//            else if address_type == "0"{
//                btnHomeRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
//                btnOffieceRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                btnHomeRef.setTitleColor(AppColor.themeColor, for: .normal)
//                btnOffieceRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//            }else{
//                btnHomeRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
//                btnOffieceRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
//                btnHomeRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
//                btnOffieceRef.setTitleColor(AppColor.themeColor, for: .normal)
//            }
            
        }else{
            
            print("Do nothing")
            
        }
    }
    
    
    
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
            
        }else if !validation.validateBlankField(txtArea.text!){
            
            message = ConstantTexts.enterArea
            
        }else if !validation.validateBlankField(txtHouse.text!){
            
            message = ConstantTexts.enterHouse
            
        }else if !validation.validateBlankField(txtPin.text!){
            
            message = ConstantTexts.enterPinCode
            
        }else if !validation.validateBlankField(txtLM.text!){
            
            message = ConstantTexts.enterLandMark
            
        }
       /* else if address_type == ""{
            message = ConstantTexts.selectAddressType
        } */
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
            
            
            var addressType = String()
            if txtHouse.text == ConstantTexts.homeAddress{
               addressType = "0"
            }else{
                addressType = "1"
            }
            
            
            
            
            let passDict = ["first_name":txtFieldFirstName.text!,
                            "last_name":txtFieldLastName.text!,
                            "email":txtEmail.text!,
                            "country_code":txtCountryCode.text!,
                            "phone":txtPhoneNumber.text!,
                            "area":txtArea.text!,
                            "address":txtArea.text!,
                            "pin":txtPin.text!,
                            "landmark":txtLM.text!,
                            "address_type":addressType,
                            "latitude":self.lat,
                            "longitude":self.long,
                            "location":txtHouse.text!,
                            "house no/building":txtArea.text!,
                            "street":txtPin.text!,
                            "building":txtBuilding.text!,
                            "floor":txtFloor.text!,
                            "apartment":txtAppartment.text!] as [String:AnyObject]
            
            print(passDict)
            
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.userupdate.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    
                    self.updateUser(first_name:self.txtFieldFirstName.text!,last_name:self.txtFieldLastName.text!,country_code:self.txtCountryCode.text!,phone:self.txtPhoneNumber.text!,email_id:self.txtEmail.text!,area:self.txtArea.text!,houseOrFlatNo:self.txtHouse.text!,pin:self.txtPin.text!,landmark:self.txtLM.text!, address_type: self.address_type, street:self.txtPin.text!,
                        building:self.txtBuilding.text!,
                        floor:self.txtFloor.text!,
                        apartment:self.txtAppartment.text!)
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
    
    func updateUser(first_name:String,last_name:String,country_code:String,phone:String,email_id:String,area:String,houseOrFlatNo:String,pin:String,landmark:String,address_type:String,street:String,
        building:String,
        floor:String,
        apartment:String){
        do{
            try realm.write {
                
                if let user = realm.objects(SignupDataModel.self).first{
                    user.first_name = first_name
                    user.last_name = last_name
                    user.country_code = country_code
                    user.phone = phone
                    user.email_id = email_id
                    user.phone = phone
                    user.area = area
                    user.houseOrFlatNo = area
                    user.pin = pin
                    user.landmark = landmark
                    user.address_type = address_type
                    
                    user.street = street
                    user.building = building
                    user.floor = floor
                    user.apartment = apartment
                    
                    _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: ConstantTexts.profileUpdated, style: .success, buttonTitle: ConstantTexts.Ok, action: { (ok) in
                        if ok{
                           super.goBackToIndex(1, animated: true)
                        }
                    })

                }
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
    
    
    
    
    
}
