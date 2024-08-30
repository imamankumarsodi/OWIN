//
//  DrawerCustomMethodExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension DrawerControllerVC{
    //TODO: Initial Setup
    
    internal func initialSetup(){
        ScreeNNameClass.shareScreenInstance.screenName = DrawerControllerVC.className

      
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.topView.bounds
        
        self.topView.layer.insertSublayer(gradientLayer, at:0)
        
        
        self.lblHeader.textColor = AppColor.whiteColor
        self.lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 20)
        checkAutoLogin()
        self.tblViewDrawer.backgroundColor = AppColor.whiteColor
        recheckModel()
      
    }
    
    
    //TODO: Naigation Setup
    internal func navigationSetUP(){
     super.transparentNavigation()
      self.hideNavigationBar(true)
        self.transparentNavigation()
        recheckModel()
    }
    
    //TODO: Recheck method
    fileprivate func recheckModel(){
        if leftModel == nil{
            leftModel = DrawerControllerVM()
        }
        setUpDataSource()
    }
    
    
    //TODO: Data Source method
    fileprivate func setUpDataSource() {
        if let arrDataSource = self.leftModel?.prepareDataSource() {
            self.dataStore = arrDataSource
        }
        self.registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblViewDrawer.register(nib: DrawerTableViewCellAndXib.className)
    }
    
    
     fileprivate func checkAutoLogin(){
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
           if userInfo.access_token != ""{
                self.lblHeader.text = "\(userInfo.first_name) \(userInfo.last_name)"
            
           }else{
            self.lblHeader.text = ConstantTexts.WelcomeAppName
           
            }
        }else{
            
            self.lblHeader.text = ConstantTexts.WelcomeAppName
            
        }
        tblViewDrawer.reloadData()
    }
    
}
