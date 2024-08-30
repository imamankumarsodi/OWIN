//
//  PaymentModeCustomMethodsExtensions.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

//MARK: - Extension Custom methods
extension PaymentModeVC{
    
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        super.hideNavigationBar(false)
        hideKeyboardWhenTappedAround()
        
        btnCODRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        btnCODRef.setTitleColor(AppColor.subtitleColor, for: .normal)
        btnCODRef.setTitle("  Cash on Delivery", for: .normal)
        
        btnCreditOrDebitRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        btnCreditOrDebitRef.setTitleColor(AppColor.subtitleColor, for: .normal)
        btnCreditOrDebitRef.setTitle("  Credit Card/Debit Card", for: .normal)
        
        lblMyPayment.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        lblMyPayment.textColor = AppColor.textColor
        lblMyPayment.text = "My Payments"
        
        
        btnAddCreditCard.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        btnAddCreditCard.setTitleColor(AppColor.subtitleColor, for: .normal)
        btnAddCreditCard.setTitle("  Add Credit Card", for: .normal)
        
        lblTitle.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblTitle.textColor = AppColor.textColor
        lblTitle.text = "Other Payment Methods"
        
        self.btnConfirmRef.backgroundColor = AppColor.stepperColor
        self.btnConfirmRef.setTitle("Done", for: .normal)
        self.btnConfirmRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        
        lblJustBiteCredit.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblJustBiteCredit.textColor = AppColor.textColor
        
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            
            lblJustBiteCredit.text = "OWIN Pay Credit: AED \(userInfo.wallet)"
            
        }
        
        AccessCurrentLocationuser()
        registerNibCol()
        
        
    }
    
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.setupNavigationBarTitle("Payment Mode", leftBarButtonsType: [.back], rightBarButtonsType: [])
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: PaymentModeVC.className)
        super.transparentNavigation()
        super.hideNavigationBar(false)
        getCardList()
    }
    
    //TODO: Register Nib method
    fileprivate func registerNibCol(){
        self.collectionView.registerMultiple(nibs: [PaymentModeCollectionViewCell.className,PaymentModeCollectionViewCell.className])
    }
    
    
    
    
    internal func placeOrderService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            let realm = try! Realm()
            var permanentAddress = String()
            var id = String()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
                permanentAddress = userInfo.address
                
            }else{
                print("do nothing")
            }
            
            if address == ""{
                address = permanentAddress
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    area = userInfo.area
                    user_current_address = permanentAddress
                    pin = userInfo.pin
                    
                }else{
                    print("do nothing")
                }
                
                
                
            }else{
                user_current_address = address
            }
            
            
            //            let header = ["X-localization":xLoc,
            //                          "Accept":"application/json"]
            
            //            let passDict = ["user_id":id as AnyObject,
            //                            "payment_type":payment_type,
            //                            "user_current_address":"Mobulous Technology Pvt. Ltd. H-146/H-147 Noida U.P.",
            //                            "area":area,
            //                            "address":address,
            //                            "pin":pin,
            //                            "latitude":19.01761470,
            //                            "longitude":72.85616440,
            //                            "extra_notes":extra_notes,
            //                            "price":price,
            //                            "discount":discount,
            //                            "totalPrice":totalPrice] as [String:AnyObject]
            
            
            //   ["totalPrice": 177.1, "pin": , "latitude": 28.625730864573764, "address": , "user_id": 61, "area": , "price": 0, "discount": 75.9, "longitude": 77.37761082125864, "user_current_address": , "extra_notes": , "payment_type": COD]
            
            
            
            
            let passDict = ["user_id":id as AnyObject,
                            "payment_type":payment_type,
                            "user_current_address":self.user_current_address,
                            "area":area,
                            "address":address,
                            "pin":pin,
                            "latitude":latitude,
                            "longitude":longitude,
                            "extra_notes":extra_notes,
                            "price":price,
                            "discount":discount,
                            "totalPrice":totalPrice] as [String:AnyObject]
            print(passDict)
            
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.placeOrder.rawValue, params: passDict as [String : AnyObject], headers: nil, success: { (responseJASON) in
                
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
                    }
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    // self.macroObj.appDelegate.openDrawer1()
                    
                    
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
    
    //TODO: Decrease badge count api
    func getCardList(){
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
            
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.cardlist.rawValue, headers: header, success: { (responseJASON) in
                if self.CardModelArray.count>0{
                    self.CardModelArray.removeAll()
                    
                }
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    print(responseJASON)
                    if let cardListArray = responseJASON["cardList"].arrayObject as? NSArray{
                        var idR = Int()
                        var card_cvvR = String()
                        var card_numberR = String()
                        var user_idR = Int()
                        var card_nameR = String()
                        var card_exp_monthR = String()
                        var card_exp_yearR = String()
                        for item in 0..<cardListArray.count{
                            if let itemdict = cardListArray[item] as? NSDictionary{
                                if let id = itemdict.value(forKey:"id") as? Int{
                                    idR = id
                                }
                                if let card_cvv = itemdict.value(forKey:"card_cvv") as?  String{
                                    card_cvvR = card_cvv
                                }
                                if let card_number = itemdict.value(forKey:"card_number") as? String{
                                    card_numberR = card_number
                                }
                                
                                if let  user_id = itemdict.value(forKey:"user_id") as? Int{
                                    user_idR = user_id
                                }
                                if let  card_name = itemdict.value(forKey:"card_name") as? String{
                                    card_nameR = card_name
                                }
                                if let  card_exp_month = itemdict.value(forKey:"card_exp_month") as? String{
                                    card_exp_monthR = card_exp_month
                                }
                                if let  card_exp_year = itemdict.value(forKey:"card_exp_year") as? String{
                                    card_exp_yearR = card_exp_year
                                }
                                
                                
                                let cardItem = CardModel(id: idR, card_cvv: card_cvvR, card_number: card_numberR, user_id: user_idR, card_name: card_nameR, card_exp_month:card_exp_monthR, card_exp_year: card_exp_yearR)
                                self.CardModelArray.append(cardItem)
                            }
                        }
                        self.collectionView.reloadData()
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
    
    internal func deleteCardService(cardId:Int,index:Int){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
            
            
            
            
            let passDict = ["card_id":cardId] as [String:AnyObject]
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.carddelete.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    
                    if let message = responseJASON["message"].stringValue as? String{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
                    }
                    
                    
                    
                    self.CardModelArray.remove(at: index)
                    if self.CardModelArray.count != 0{
                        self.macroObj.hideLoaderEmpty(view: self.collectionView)
                        self.collectionView.reloadData()
                        
                    }else{
                        self.macroObj.showLoaderEmpty(view: self.collectionView)
                        self.collectionView.reloadData()
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
    
}
