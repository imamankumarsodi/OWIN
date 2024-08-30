//
//  OfferTableViewCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension OfferVC{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        update()
    }
    
    //TODO: Update UI
    
    fileprivate func update(){
        self.tblOrders.addSubview(self.refreshControl)
        hideKeyboardWhenTappedAround()
        registerNib()
        offerService()
        
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetup(){
        
      
        super.hideNavigationBar(false)
        super.transparentNavigation()
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
       
        if isCominng == "Cart"{
              super.setupNavigationBarTitle("Offers", leftBarButtonsType: [.back], rightBarButtonsType: [])
        }else{
           super.setupNavigationBarTitle("Offers", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        }
        
        
        if isComing == "HOME"{
            super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: "OfferVCHome")
        }else{
            super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: OfferVC.className)
        }
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblOrders.register(nib: OfferTableViewCellAndXib.className)
    }
    
    
    
    
    internal func offerService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            let realm = try! Realm()
            //var id = String()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                //id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            macroObj.showLoader(view: view)
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.offer.rawValue, headers: header, success: { (responseJASON) in
                
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                if self.favModelArray.count > 0{
                    self.favModelArray.removeAll()
                }
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let topRatedArr = responseJASON["offerList"].arrayObject as? NSArray{
                        for topItem in topRatedArr{
                            if let topItemDict = topItem as? NSDictionary{
                                
                                var idR = Int()
                                var restorent_idR = Int()
                                var typeR = Int()
                                var thumbnailR = String()
                                var valid_dateR = String()
                                var discountR = Int()
                                var noteR = String()
                                var res_nameR = String()
                                
                                if let id = topItemDict.value(forKey: "id") as? Int{
                                    idR = id
                                }
                                
                                if let restorent_id = topItemDict.value(forKey: "restorent_id") as? Int{
                                    restorent_idR = restorent_id
                                }
                                
                                if let type = topItemDict.value(forKey: "type") as? Int{
                                    typeR = type
                                }
                                
                                
                                
                                if let thumbnail = topItemDict.value(forKey: "res_name") as? String{
                                    res_nameR = String(thumbnail)
                                }
                                
                                
                                if let thumbnail = topItemDict.value(forKey: "thumbnail") as? String{
                                    thumbnailR = String(thumbnail)
                                }
                                
                                if let note = topItemDict.value(forKey: "note") as? String{
                                    noteR = String(note)
                                }
                                
                                if let valid_date = topItemDict.value(forKey: "valid_date") as? String{
                                    valid_dateR = valid_date
                                }
                                
                                
                                if let discount = topItemDict.value(forKey: "discount") as? Int{
                                    discountR = discount
                                }
                                
                               
                                
                                let restModelItem = OfferListDataModel(id: idR, restorent_id: restorent_idR, type: typeR, thumbnail: thumbnailR, valid_date: valid_dateR, discount: discountR, note: noteR, res_name: res_nameR)
                                
                                self.favModelArray.append(restModelItem)
                            }
                        }
                    }
                    
                    if self.favModelArray.count > 0{
                        self.tblOrders.reloadData()
                    }else{
                        self.tblOrders.reloadData()
                        self.macroObj.showLoaderEmpty(view: self.tblOrders)
                        self.macroObj.hideLoaderNet(view: self.tblOrders)
                        self.macroObj.hideWentWrong(view: self.tblOrders)
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
                self.macroObj.showWentWrong(view: self.tblOrders)
                
                self.macroObj.hideLoaderEmpty(view: self.tblOrders)
                self.macroObj.hideLoaderNet(view: self.tblOrders)
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblOrders)
            macroObj.hideLoaderEmpty(view: self.tblOrders)
            macroObj.hideWentWrong(view: self.tblOrders)
        }
    }
    
}
