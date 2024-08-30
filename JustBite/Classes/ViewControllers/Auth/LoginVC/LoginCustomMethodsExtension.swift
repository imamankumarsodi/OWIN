//
//  LoginCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 04/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields
import RealmSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
//MARK: - Extension Custom methods

extension LoginVC{
    
    //TODO: Initial Setup
    
    
    
    internal func initialSetup(){
        
        updateUI()
    }
    
    //TODO: UpdateUI method
    
    fileprivate func updateUI(){
        
        hideKeyboardWhenTappedAround()
        ScreeNNameClass.shareScreenInstance.screenName = LoginVC.className
        GIDSignIn.sharedInstance()?.presentingViewController = self

        self.lblHeading.attributedText = GlobalCustomMethods.shared.attributedString(title: "Proceed with your", subTitle: "Login",delemit:"\n", sizeTitle: 18.0, sizeSubtitle: 24.0, titleColor: AppColor.textColor, SubtitleColor: AppColor.textColor)
        self.lblFooter.attributedText = GlobalCustomMethods.shared.attributedStringFooter(title: "Don't have an account?", subTitle: "SIGN UP",delemit:" ", sizeTitle: 18.0, sizeSubtitle: 18.0, titleColor: #colorLiteral(red: 0.4600000083, green: 0.4600000083, blue: 0.4600000083, alpha: 1), SubtitleColor: AppColor.themeColor)
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnLoginRef, title: "LOGIN")
        
       
        btnSkip.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        btnSkip.setTitle("", for: .normal)
        btnSkip.backgroundColor = AppColor.whiteColor
        btnSkip.setTitleColor(AppColor.placeHolderColor, for: .normal)
        
        
        
        txtEmail?.autocapitalizationType = .none
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
        txtEmail?.placeholder = ConstantTexts.emailPhonePlaceHoler
        txtEmail?.underline?.isHidden = false
        txtEmail?.clearButton.isHidden = false
        txtEmail?.keyboardType = .default
        
        
        txtPassword?.autocapitalizationType = .none
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
        
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        lblFooter.isUserInteractionEnabled = true
        lblFooter.addGestureRecognizer(tap)
        
        recheckModel()
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
            loginModel = LoginVM()
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
        self.tblViewLogin.registerMultiple(nibs: [LoginCell.className,phoneWithcounrtyAndCellTableViewCell.className])
        
    }
    
    
    internal func validationSetup(){
        
        var message = ""
        
        if !validation.validateBlankField(txtEmail.text!){
            
            message = ConstantTexts.enterEmailPhone
            
        }else if !validation.validateBlankField(txtPassword.text!){
            
            message = ConstantTexts.password
            
        }else if (txtPassword.text!.count < 6 ){
            
            message = ConstantTexts.validPassword
            
        }
        if message != "" {
            
            _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: AlertStyle.error)
            
        }else{
            
            loginService()
        }
        
    }
    
    fileprivate func loginService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let devicetoken = UserDefaults.standard.value(forKey: "devicetoken") as? String ?? "Simulaterwalatokenbb55d44bfc4492bd33aac79afeaee474e92c12138e18b021e2326"
            var type = String()
            var passDict = [String:AnyObject]()
            if Int(txtEmail.text!) != nil{
                type = "phone"
                passDict = ["type":type,
                            "phone_no":txtEmail.text!,
                            "password":txtPassword.text!,
                            "device_type":"ios",
                            "device_token":devicetoken] as [String : AnyObject]
                
            }else{
                type = "email"
                passDict = ["type":type,
                            "email":txtEmail.text!,
                            "password":txtPassword.text!,
                            "device_type":"ios",
                            "device_token":devicetoken] as [String : AnyObject]
            }
            
            
            
            let header = ["Content-Type":"application/json",
                          "Accept":"application/x-www-form-urlencoded"]
            
            print(passDict)
            print(devicetoken)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.login.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    if let dataDict = responseJASON["loginResponse"].dictionaryObject as? NSDictionary{
                        let signup_data = SignupDataModel()
                        
                        if let wallet = responseJASON["wallet"].intValue as? Int{
                            signup_data.wallet = wallet
                        }
                        
                        
                        if let authDict = dataDict.value(forKey: "auth") as? NSDictionary{
                            if let token_type = authDict["token_type"] as? String{
                                signup_data.token_type = token_type
                            }
                            
                            if let expires_in = authDict["expires_in"] as? Int{
                                signup_data.expires_in = String(expires_in)
                            }
                            
                            if let access_token = authDict["access_token"] as? String{
                                signup_data.access_token = access_token
                            }
                            
                            if let refresh_token = authDict["refresh_token"] as? String{
                                signup_data.refresh_token = refresh_token
                            }
                            
                        }
                        
                        
                        if let userDict = dataDict.value(forKey: "user") as? NSDictionary{
                            
                            if let id = userDict["id"] as? Int{
                                signup_data.id = String(id)
                            }
                            
                            if let email_id = userDict["email_id"] as? String{
                                signup_data.email_id = email_id
                            }
                            
                            if let first_name = userDict["first_name"] as? String{
                                signup_data.first_name = first_name
                            }
                            
                            if let last_name = userDict["last_name"] as? String{
                                signup_data.last_name = last_name
                            }
                            
                            if let phone = userDict["phone"] as? String{
                                signup_data.phone = phone
                            }
                            
                            if let facebook_id = userDict["facebook_id"] as? String{
                                signup_data.facebook_id = facebook_id
                            }
                            
                            if let google_id = userDict["google_id"] as? String{
                                signup_data.facebook_id = google_id
                            }
                            
                            if let address = userDict["address"] as? String{
                                signup_data.address = address
                            }
                            
                            if let address_type = userDict["address_type"] as? Int{
                                signup_data.address_type = String(address_type)
                            }
                            
                            if let is_phone_verify = userDict["is_phone_verify"] as? Int{
                                signup_data.is_phone_verify = String(is_phone_verify)
                            }
                            
                            if let signup_by = userDict["signup_by"] as? String{
                                signup_data.signup_by = signup_by
                            }
                            
                            if let status = userDict["status"] as? String{
                                signup_data.status = status
                            }
                            
                            if let created_at = userDict["created_at"] as? String{
                                signup_data.created_at = created_at
                            }
                            
                            if let updated_at = userDict["updated_at"] as? String{
                                signup_data.updated_at = updated_at
                            }
                            
                            if let country_code = userDict["country_code"] as? String{
                                signup_data.country_code = country_code
                            }
                            
                            if let area = userDict["area"] as? String{
                                signup_data.area = area
                            }
                            
                            if let pin = userDict["pin"] as? String{
                                signup_data.pin = pin
                            }
                            
                            if let landmark = userDict["landmark"] as? String{
                                signup_data.landmark = landmark
                            }
                            if let houseOrFlatNo = userDict["houseOrFlatNo"] as? String{
                                signup_data.houseOrFlatNo = houseOrFlatNo
                            }
                            
                        }
                        
                        self.save(userInfo: signup_data)
                        
                        
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
    
 
    func save(userInfo:SignupDataModel){
        do{
            try realm.write {
                if let user = realm.objects(SignupDataModel.self).first{
                    
                    
                    user.token_type = userInfo.token_type
                    user.expires_in = userInfo.expires_in
                    user.access_token = userInfo.access_token
                    user.refresh_token = userInfo.refresh_token
                    
                    user.id = userInfo.id
                    user.first_name = userInfo.first_name
                    user.last_name = userInfo.last_name
                    user.country_code = userInfo.country_code
                    user.phone = userInfo.phone
                    user.email_id = userInfo.email_id
                    user.phone = userInfo.phone
                    user.area = userInfo.area
                    user.houseOrFlatNo = userInfo.houseOrFlatNo
                    user.pin = userInfo.pin
                    user.landmark = userInfo.landmark
                    user.address_type = userInfo.address_type
                    user.facebook_id = userInfo.facebook_id
                    user.google_id = userInfo.google_id
                    user.address = userInfo.address
                    user.is_phone_verify = userInfo.is_phone_verify
                    user.signup_by = userInfo.signup_by
                    user.status = userInfo.status
                    user.created_at = userInfo.created_at
                    user.updated_at = userInfo.updated_at
                    
                }else{
                    realm.add(userInfo)
                }
                
                
                
                moveToHomeVC1()
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
    
    
    
    func moveToHomeVC1(){
        
        
        
        
        
        
        //        "": "Greaterr Kailash Sridham Dhaba",
        //        "": "Cheese Blast Pizza",
        //        "": "http:\/\/3.8.172.240\/just_bite\/public\/storage\/menu\/thumbnail\/1563778853_recipe-pizza-pollo-arrosto.jpg",
        //        "": "380.0",
        //        "": "1",
        //        "": 1,
        //        "": "Apetizers",
        //        "": [
        //        "42",
        //        "40",
        //        "45"
        //        ]
        
        
        
        let realm = try! Realm()
        let orders = realm.objects(OrderItem.self)
        var orderNSArray = NSMutableArray()
        
        if orders.count > 0{
            print("yaha api hit karani hai")
            for order in orders{
                var orderDict = [String:Any]() // dict is of type Dictionary<Int, String>
                orderDict["id"] = order.id
                orderDict["restaurant_id"] = order.RestaurentId
                orderDict["restaurant_name"] = order.restName
                orderDict["name"] = order.name
                orderDict["Image"] = order.img
                orderDict["price"] = order.price
                orderDict["Item_type"] = order.itemType
                orderDict["Quantity"] = order.totolQuantity
                orderDict["CatName"] = order.catName
                orderDict["customizes"] = order.addOns.components(separatedBy: ",")
                
                
                orderNSArray.add(orderDict)
                
            }
            print(orderNSArray)
            for item in orderNSArray{
                if let itemDict = item as? NSDictionary{
                    print(itemDict)
                }
            }
            
            self.updateUserService(menuList:orderNSArray)
            
            // print("THE IOFIU", orderNSArray)
            
            
        }else{
            let viewController = AppStoryboard.tabbarClass as! TabBarViewC
            let navigationController = UINavigationController(rootViewController: viewController)
            viewController.selectedIndex = 0
            navigationController.navigationBar.isHidden = true
            APPLICATION.keyWindow?.rootViewController = navigationController
        }
        
        
    }
    
    
    fileprivate func updateUserService(menuList:NSMutableArray){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
            
            let passDict = ["menuList":menuList] as [String:AnyObject]
            print(passDict)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.addtocartall.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    let orders = self.realm.objects(OrderItem.self)
                    do{
                        try self.realm.write {
                            self.realm.delete(orders)
                            
                        }
                    }catch{
                        print("Error in saving data :- \(error.localizedDescription)")
                    }
                    
                    print("cart delete karao aage bhej do")
                    let viewController = AppStoryboard.tabbarClass as! TabBarViewC
                    let navigationController = UINavigationController(rootViewController: viewController)
                    viewController.selectedIndex = 0
                    navigationController.navigationBar.isHidden = true
                    APPLICATION.keyWindow?.rootViewController = navigationController
                    print("cart delete karao aage bhej do")
                   
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

extension LoginVC:GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if InternetConnection.internetshared.isConnectedToNetwork(){
            self.macroObj.showLoader(view: self.view)
            if error != nil{
                
                self.macroObj.hideLoader(view: self.view)
                print(error)
                if let errorStr = error.localizedDescription as? String{
                    print(errorStr)
                    _ = SweetAlert().showAlert(macroObj.appName, subTitle: errorStr, style: AlertStyle.error)
                }
                
                
            }else{
                self.macroObj.hideLoader(view: self.view)
                print(user)
                
                var profilePicUrlStringR = String()
                var idTokenR = String()
                var fullNameR = String()
                var givenNameR = String()
                var familyNameR = String()
                var emailR = String()
                var useriDR = String()
                
                if let profilePicUrlString = user.profile.imageURL(withDimension: 300) as? String {
                    print(profilePicUrlString)
                    profilePicUrlStringR = profilePicUrlString
                }
                if let userId  = user.userID as? String{
                    print(userId)
                    useriDR = userId
                }
                if let fullName  = user.profile.name as? String{
                    print(fullName)
                    fullNameR = fullName
                }
                if let givenName  = user.profile.givenName as? String{
                    print(givenName)
                    givenNameR = givenName
                }
                if let familyName  = user.profile.familyName as? String{
                    print(familyName)
                    familyNameR = familyName
                }
                if let email  = user.profile.email as? String{
                    print(email)
                    emailR = email
                }
                if let idToken  = user.authentication.idToken as? String{
                    print(idToken)
                    idTokenR = idToken
                }
                socialMediaApi(facebook_id:String(),first_name:givenNameR,last_name:familyNameR,email:emailR,signup_by:"google",google_id:useriDR,social_id:useriDR)
                
            }
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            
        }
    }
    
    func FBLoginSetUP(){
        let fblogINManager:LoginManager = LoginManager()
        if InternetConnection.internetshared.isConnectedToNetwork(){
            fblogINManager.logIn(permissions: ["email","public_profile"], from: self) { (result, error) in
                if error != nil {
                    self.macroObj.hideLoader(view: self.view)
                    print("Get an error\(error?.localizedDescription)")
                }
                else{
                    self.macroObj.hideLoader(view: self.view)
                    self.getFbData()
                    fblogINManager.logOut()
                }
                
            }
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    
    
    func getFbData()
    {
        if InternetConnection.internetshared.isConnectedToNetwork(){
            if (AccessToken.current != nil){
                GraphRequest(graphPath: "me", parameters: ["fields": "id ,name , first_name , last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) in
                    self.macroObj.showLoader(view: self.view)
                    if error != nil{
                        self.macroObj.hideLoader(view: self.view)
                        print("Get error\(error?.localizedDescription)")
                    }
                    else{
                        
                        self.macroObj.hideLoader(view: self.view)
                        if let dataDict = result as? [String : AnyObject]{
                            print(dataDict)
                            
                            guard let socialID = dataDict["id"] as? String else {
                                print("No socialID")
                                return
                            }
                            guard let first_name = dataDict["first_name"] as? String else {
                                print("No first_name")
                                return
                            }
                            guard let last_name = dataDict["last_name"] as? String else {
                                print("No last_name")
                                return
                            }
                            guard let name = dataDict["name"] as? String else {
                                print("No name")
                                return
                            }
                            
                            let email = dataDict["email"] as? String ?? ""
                            
                            
                            
                            if let pictureDict = dataDict["picture"] as? [String:AnyObject]{
                                if let pictureData = pictureDict["data"] as? [String:AnyObject]{
                                    guard let url = pictureData["url"] as? String else {
                                        print("No url")
                                        return
                                    }
                                }
                            }
                            self.socialMediaApi(facebook_id:socialID,first_name:first_name,last_name:last_name,email:email,signup_by:"fb",google_id:String(),social_id:socialID)
                            
                        }
                        
                    }
                })
            }
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    internal func socialMediaApi(facebook_id:String,first_name:String,last_name:String,email:String,signup_by:String,google_id:String,social_id:String){
        self.macroObj.showLoader(view: self.view)
        let devicetoken = UserDefaults.standard.value(forKey: "devicetoken") as? String ?? "Simulaterwalatokenbb55d44bfc4492bd33aac79afeaee474e92c12138e18b021e2326"
        let passDict = ["facebook_id":facebook_id,
                        "first_name":first_name,
                        "last_name":last_name,
                        "email":email,
                        "signup_by":signup_by,
                        "google_id":google_id,
                        "social_id":social_id,
                        "device_type":"ios",
                        "device_token":devicetoken] as [String:AnyObject]
        print(passDict)
        
        alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.socialmedialogin.rawValue, params: passDict, headers: nil, success: { (responseJASON) in
            print(responseJASON)
            if responseJASON["status"].string == "true"{
                if let dataDict = responseJASON["socialMediaLogin"].dictionaryObject as? NSDictionary{
                    let signup_data = SignupDataModel()
                    
                    if let wallet = responseJASON["wallet"].intValue as? Int{
                        signup_data.wallet = wallet
                    }
                    if let authDict = dataDict.value(forKey: "auth") as? NSDictionary{
                        if let token_type = authDict["token_type"] as? String{
                            signup_data.token_type = token_type
                        }
                        
                        if let expires_in = authDict["expires_in"] as? Int{
                            signup_data.expires_in = String(expires_in)
                        }
                        
                        if let access_token = authDict["access_token"] as? String{
                            signup_data.access_token = access_token
                        }
                        
                        if let refresh_token = authDict["refresh_token"] as? String{
                            signup_data.refresh_token = refresh_token
                        }
                        
                    }
                    
                    
                    if let userDict = dataDict.value(forKey: "user") as? NSDictionary{
                        
                        if let id = userDict["id"] as? Int{
                            signup_data.id = String(id)
                        }
                        
                        if let email_id = userDict["email_id"] as? String{
                            signup_data.email_id = email_id
                        }
                        
                        if let first_name = userDict["first_name"] as? String{
                            signup_data.first_name = first_name
                        }
                        
                        if let last_name = userDict["last_name"] as? String{
                            signup_data.last_name = last_name
                        }
                        
                        if let phone = userDict["phone"] as? String{
                            signup_data.phone = phone
                        }
                        
                        if let facebook_id = userDict["facebook_id"] as? String{
                            signup_data.facebook_id = facebook_id
                        }
                        
                        if let google_id = userDict["google_id"] as? String{
                            signup_data.facebook_id = google_id
                        }
                        
                        if let address = userDict["address"] as? String{
                            signup_data.address = address
                        }
                        
                        if let address_type = userDict["address_type"] as? Int{
                            signup_data.address_type = String(address_type)
                        }
                        
                        if let is_phone_verify = userDict["is_phone_verify"] as? Int{
                            signup_data.is_phone_verify = String(is_phone_verify)
                        }
                        
                        if let signup_by = userDict["signup_by"] as? String{
                            signup_data.signup_by = signup_by
                        }
                        
                        if let status = userDict["status"] as? String{
                            signup_data.status = status
                        }
                        
                        if let created_at = userDict["created_at"] as? String{
                            signup_data.created_at = created_at
                        }
                        
                        if let updated_at = userDict["updated_at"] as? String{
                            signup_data.updated_at = updated_at
                        }
                        
                        if let country_code = userDict["country_code"] as? String{
                            signup_data.country_code = country_code
                        }
                        
                        if let area = userDict["area"] as? String{
                            signup_data.area = area
                        }
                        
                        if let pin = userDict["pin"] as? String{
                            signup_data.pin = pin
                        }
                        
                        if let landmark = userDict["landmark"] as? String{
                            signup_data.landmark = landmark
                        }
                        if let houseOrFlatNo = userDict["houseOrFlatNo"] as? String{
                            signup_data.houseOrFlatNo = houseOrFlatNo
                        }
                        
                    }
                    
                    self.save(userInfo: signup_data)
                    
                    
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

