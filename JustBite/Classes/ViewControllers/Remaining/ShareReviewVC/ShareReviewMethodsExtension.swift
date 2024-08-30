//
//  ShareReviewMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension ShareReviewVC{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        update()
    }
    
    //TODO: Update UI
    
    fileprivate func update(){
        hideKeyboardWhenTappedAround()
        
        lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringForgotPassword(title: "Share Ratings & Reviews", subTitle: "Share Ratings as per your experience with\nthe Restaurant food.", delemit: "\n", sizeTitle: 17, sizeSubtitle: 17, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
        
        
        
        
        txtView.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 14)
        txtView.textColor = AppColor.placeHolderColor
        txtView.text = "Write here..."
        txtView.delegate = self
        
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: viewText)
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: viewText)
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: viewText, radius: 10)
        viewText.backgroundColor = AppColor.whiteColor
        
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnLoginRef, title: "Submit")
        
        
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetup(){
        super.setupNavigationBarTitle("Share Reviews", leftBarButtonsType: [.back], rightBarButtonsType: [])
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
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: ShareReviewVC.className)
    }
    
    
    
    
}


extension ShareReviewVC:UITextViewDelegate{
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (txtView.text == "Write here...")
            
        {
            txtView.text = nil
            txtView.textColor = AppColor.textColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtView.text.isEmpty
        {
            txtView.text = "Write here..."
            txtView.textColor = AppColor.placeHolderColor
        }
        textView.resignFirstResponder()
    }
    
    
    internal func rate(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var token_type = String()
            var access_token = String()
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                            "Accept":"application/json"]
            
            if txtView.text == "Write here..."{
                txtView.text = ""
            }
            
            let passDict = ["restorent_id":self.id,
                            "order_id":self.order_id,
                            "rating":viewCosmos.rating,
                            "review":txtView.text!] as [String:AnyObject]
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.restorentrating.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    super.backButtonTapped()
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
    
    func validation(){
        if viewCosmos.rating != 0{
             rate()
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.selectRating, style: AlertStyle.error)
        }
    }
    
}
