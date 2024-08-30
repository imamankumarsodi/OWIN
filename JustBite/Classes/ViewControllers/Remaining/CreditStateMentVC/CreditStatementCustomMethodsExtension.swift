//
//  CreditStatementCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension CreditStatementVC{
    //TODO: Initial Setup
    
    internal func initialSetup(){
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            self.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: "Available Credit", subTitle: "AED \(userInfo.wallet)", delemit: " ", sizeTitle: 20, sizeSubtitle: 20, titleColor: AppColor.textColor, SubtitleColor: AppColor.whiteColor)
        }
         self.tblViewDrawer.addSubview(self.refreshControl)
        lblDetails.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
        lblDetails.textColor = AppColor.textColor
        lblDetails.text = "Credit History"
        
        self.registerNib()
        navigationSetUP()
        topuplist()
    }
    
    
    //TODO: Naigation Setup
    internal func navigationSetUP(){
        preferredStatusBarStyle
        super.transparentNavigation()
        super.setupNavigationBarTitle("Credit Statement", leftBarButtonsType: [.back], rightBarButtonsType: [])
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: CreditStatementVC.className)
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            self.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: "Available Credit", subTitle: "AED \(userInfo.wallet)", delemit: " ", sizeTitle: 20, sizeSubtitle: 20, titleColor: AppColor.textColor, SubtitleColor: AppColor.whiteColor)
        }
       
        //   super.hideNavigationBar(true)
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblViewDrawer.register(nib: CreditStatementsTableViewCell.className)
    }
    
    
    
    func topuplist()
    {
        if InternetConnection.internetshared.isConnectedToNetwork(){
            self.macroObj.showLoader(view: self.view)
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
           
            let header = ["Content-Type":"application/json",
                          "Authorization":"\(token_type) \(access_token)"]
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.topuphistory.rawValue, headers: header, success: { (resJson) in
                print(resJson)
                if let status = resJson["status"].stringValue as? String{
                    if self.dataStore.count > 0{
                        self.dataStore.removeAll()
                    }
                    self.macroObj.hideLoader(view: self.view)
                    if let dataArray = resJson["topupHistory"].arrayObject as? NSArray{
                        var priceR = Int()
                        var idR = Int()
                        var descriptionR = String()
                        var created_atR = String()
                        var typeR = String()
                        
                        for item in dataArray{
                            if let itemDict = item as? NSDictionary{
                                if let price = itemDict.value(forKey: "price") as? Int{
                                    priceR = price
                                }
                                if let id = itemDict.value(forKey: "id") as? Int{
                                    idR = id
                                }
                                if let description = itemDict.value(forKey: "description") as? String{
                                    descriptionR = description
                                }
                                
                                if let created_at = itemDict.value(forKey: "created_at") as? String{
                                    created_atR = created_at
                                }
                                
                                
                                if let type = itemDict.value(forKey: "type") as? String{
                                    typeR = type
                                }
                                
                                let itemmodel = TopupHistoryList(description: descriptionR, id: idR, price: priceR, created_at: created_atR, type: typeR)
                                self.dataStore.append(itemmodel)
                            }
                            
                        }
                        self.tblViewDrawer.reloadData()
                    }
                    
                }
                else{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = resJson["message"].stringValue as? String{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                }
                
            }, failure: { (Error) in
                
                self.macroObj.hideLoader(view: self.view)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
            })
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    
    
}
