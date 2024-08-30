//
//  RestaurentsFilterPopUpVCCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension RestaurentsFilterPopUpVC{
    //TODO: Initial Setup
    internal func initialStup(){
        getCuisineApi()
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewMain, radius: 5)
        viewLine.backgroundColor = AppColor.placeHolderColor
        viewHeader.backgroundColor = AppColor.stepperColor
        
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        
        lblPriceTitle.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblPriceTitle.textColor = AppColor.textColor
        
        lblPriceValue.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblPriceValue.textColor = AppColor.themeColor
        
        lblRating.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblRating.textColor = AppColor.textColor
        
        btnCusineRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        btnCusineRef.titleLabel?.textColor = AppColor.textColor
        btnCusineRef.setTitle("Cuisines", for: .normal)
        
        self.btnCancelRef.titleLabel?.textColor = AppColor.whiteColor
        self.btnDoneRef.titleLabel?.textColor = AppColor.whiteColor
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnCancelRef, title: "Cancel")
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnDoneRef, title: "Apply")
        
        sliderRef.minimumTrackTintColor = AppColor.themeColor
        sliderRef.maximumTrackTintColor = AppColor.placeHolderColor
        sliderRef.maximumValue = 10000
        
        
        
    }
    
    
    //TODO: Decrease badge count api
    func getCuisineApi(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            macroObj.showLoader(view: view)
            
            var xLoc = "en"
            let realm = try! Realm()
            var id = String()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.cuisinelist.rawValue, headers: header, success: { (responseJASON) in
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    print(responseJASON)
                    if let cuisine = responseJASON["cuisine"].arrayObject as? NSArray{
                        for item in cuisine{
                            if let itemDict = item as? NSDictionary{
                                if let name = itemDict.value(forKey: "name") as? String{
                                    self.cuisinesNameArray.append(name)
                                }
                                
                                if let id = itemDict.value(forKey: "id") as? Int{
                                    self.cuisinesIdArray.append(id)
                                }
                            }
                        }
                    }
                    self.dropDown.anchorView = self.btnCusineRef
                    self.dropDown.dataSource = self.cuisinesNameArray
                    self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        self.btnCusineRef.setTitle(item, for: .normal)
                        self.index = index
                        self.cuisineId = String(self.cuisinesIdArray[index])
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
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
}
