//
//  PaymentCustomMethodVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

//MARK: - Extension Custom methods
extension PaymentsVC{
    
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        super.hideNavigationBar(false)
        hideKeyboardWhenTappedAround()
        
       
        
        lblMyPayment.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblMyPayment.textColor = AppColor.textColor
        lblMyPayment.text = "My Payments"
        
        
        btnAddCreditCard.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
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
        
        
        registerNibCol()
        
    }
    
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
     
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
           super.setupNavigationBarTitle("Payments", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: PaymentsVC.className)
        super.transparentNavigation()
        super.hideNavigationBar(false)
        self.macroObj.hideLoaderEmpty(view: self.collectionView)
         registerNibCol()
        
    }
    
    //TODO: Register Nib method
    fileprivate func registerNibCol(){
        self.collectionView.registerMultiple(nibs: [PaymentModeCollectionViewCell.className,PaymentModeCollectionViewCell.className])
        getCardList()
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
