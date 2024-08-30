//
//  ProfileCustomMethodExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension ProfileVC{
    internal func initialSetup(){
        
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        hideKeyboardWhenTappedAround()
        ScreeNNameClass.shareScreenInstance.screenName = ProfileVC.className
        tblProfile.backgroundColor = AppColor.whiteColor
        
        lblName.font = AppFont.Bold.size(AppFontName.SourceSansPro, size: 20)
        lblName.textColor = AppColor.textColor
        checkAutoLogin()
       
        
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
         super.setupNavigationBarTitle("My Profile", leftBarButtonsType: [.menu], rightBarButtonsType: [.cart])
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: ProfileVC.className)
        checkAutoLogin()
    }
    
    
    
    //TODO: Recheck method
    fileprivate func recheckModel(userInfo:SignupDataModel){
        if profileModel == nil{
            profileModel = ProfileVM()
        }
        setUpDataSource(userInfo: userInfo)
    }
    
    //TODO: Data Source method
    fileprivate func setUpDataSource(userInfo:SignupDataModel) {
        if let arrDataSource = self.profileModel?.prepareDataSource(userInfo: userInfo) {
            self.dataStore1 = arrDataSource.0
            self.dataStore2 = arrDataSource.1
            tblProfile.reloadData()
        }
        self.registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblProfile.register(nib: LoginCell.className)
    }
    
    
    fileprivate func checkAutoLogin(){
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            
            if userInfo.access_token != ""{
                viewProfileService()
            }else{
                print("pop up dikha do login wala")
            }
        }else{
            
            print("Do nothing")
            
        }
    }
    
    
    
        internal func viewProfileService(){
            if InternetConnection.internetshared.isConnectedToNetwork(){
                let realm = try! Realm()
                var token_type = String()
                var access_token = String()
    
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    token_type = userInfo.token_type
                    access_token = userInfo.access_token
                }
    
                let header = ["Authorization":"\(token_type) \(access_token)",
                    "Accept":"application/json"]
    
                macroObj.showLoader(view: view)
                alamoFireObj.getRequestURL(MacrosForAll.APINAME.userdetails.rawValue, headers: header, success: { (responseJASON) in
    
                    
                    print(responseJASON)
                    
                    if responseJASON["status"].string == "true"{
                        self.macroObj.hideLoader(view: self.view)
                        let realm = try! Realm()
                        
                        do{
                            
                            try realm.write {
                                
                                if let userInfo = realm.objects(SignupDataModel.self).first{
                                    if let user = responseJASON["userDetails"].dictionaryObject as? NSDictionary{
                                        userInfo.area = user.value(forKey: "area") as? String ?? ""
                                        userInfo.address_type = String(user.value(forKey: "address_type") as? Int ?? 0)
                                    
                                        
                                        userInfo.pin = user.value(forKey: "pin") as? String ?? ""
                                        userInfo.id = "\(user.value(forKey: "id") as? Int ?? 0)"
                                        userInfo.first_name = user.value(forKey: "first_name") as? String ?? ""
                                        userInfo.status = user.value(forKey: "status") as? String ?? ""
                                        userInfo.country_code = String(user.value(forKey: "country_code") as? Int ?? 0)
                                        userInfo.google_id = user.value(forKey: "google_id") as? String ?? ""
                                        userInfo.email_id = user.value(forKey: "email") as? String ?? ""
                                        userInfo.landmark = user.value(forKey: "landmark") as? String ?? ""
                                        userInfo.address = user.value(forKey: "address") as? String ?? ""
                                        userInfo.is_phone_verify = user.value(forKey: "is_phone_verify") as? String ?? ""
                                        userInfo.phone = user.value(forKey: "phone") as? String ?? ""
                                        userInfo.last_name = user.value(forKey: "last_name") as? String ?? ""
                                        userInfo.street = user.value(forKey: "street") as? String ?? ""
                                        userInfo.building = user.value(forKey: "building") as? String ?? ""
                                        userInfo.floor = user.value(forKey: "floor") as? String ?? ""
                                        userInfo.apartment = user.value(forKey: "apartment") as? String ?? ""
                                        
                                        
                                    }
                                    
                                    self.lblName.text = "\(userInfo.first_name) \(userInfo.last_name)"
                                    self.address_type = userInfo.address_type
                                    self.recheckModel(userInfo: userInfo)
                                }else{
                                    print("do nothing")
                                }
                            }
                            
                        }catch{
                            print("Error in saving data :- \(error.localizedDescription)")
                        }
//
                        
                        
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
