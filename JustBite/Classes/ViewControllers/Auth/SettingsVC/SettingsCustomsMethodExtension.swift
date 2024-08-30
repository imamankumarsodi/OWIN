//
//  SettingsCustomsMethodExtension.swift
//  JustBite
//
//  Created by Aman on 08/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension SettingsVC{
    //TODO: Initial Setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        ScreeNNameClass.shareScreenInstance.screenName = SettingsVC.className
//
//        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
//
//        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
//        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
//        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
//
//        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
//        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
//
//
//        gradientLayer.frame = self.GradinetView.bounds
//
//        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
//
//        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: SettingsVC.className)
//        self.lblNotification.text = "Notifications"
//        self.lblNotification.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 18)
//        self.lblNotification.textColor = AppColor.textColor
        hideKeyboardWhenTappedAround()
        //recheckModel()
        self.registerNib()
       
    }
    
    //TODO: Navigation setup
     func navigationSetup(){
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
         super.setupNavigationBarTitle("Settings", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: SettingsVC.className)
    }
    
    
    //TODO: Recheck method
    fileprivate func recheckModel(){
        if settingModel == nil{
            settingModel = SettingVM()
        }
        setUpDataSource()
    }
    
    //TODO: Data Source method
    fileprivate func setUpDataSource() {
        if let arrDataSource = self.settingModel?.prepareDataSource() {
            self.dataStore = arrDataSource
        }
        self.registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblSetting.register(nib: ChangePasswordCell.className)
    }
    
    
    
    //TODO: Decrease badge count api
    func logoutApi(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            macroObj.showLoader(view: view)
            
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                          "Accept":"application/json"]
            
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.logout.rawValue, headers: header, success: { (responseJASON) in
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let userInfo = self.realm.objects(SignupDataModel.self).first{
                        self.deleteUser(userInfo:userInfo)
                    }
                }else{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].stringValue as? String{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                    
                }
                
                
            }, failure: { (error) in
                self.macroObj.hideLoader(view: self.view)
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
            })
            
        }
        else{
            self.macroObj.hideLoader(view: self.view)
             _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    
    func deleteUser(userInfo:SignupDataModel){
        do{
            try realm.write {
                realm.delete(userInfo)
                super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }

    
}
