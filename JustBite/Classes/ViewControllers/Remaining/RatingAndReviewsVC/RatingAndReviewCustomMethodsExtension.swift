//
//  RatingAndReviewCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension RatingAndReviewsVC{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        update()
    }
    
    //TODO: Update UI
    
    fileprivate func update(){
        hideKeyboardWhenTappedAround()
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        lblHeader.textColor = AppColor.themeColor
        
        viewCosmos.settings.fillMode = .half
        
        lblDetails.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        lblDetails.textColor = AppColor.textColor
        self.tblAddOns.tableFooterView = UIView()
        self.tblAddOns.addSubview(self.refreshControl)
        hitRestInfoService(id:self.id)
        
        registerNib()
       
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetup(){
        super.setupNavigationBarTitle("Rating & Reviews", leftBarButtonsType: [.back], rightBarButtonsType: [])
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
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: RatingAndReviewsVC.className)
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblAddOns.register(nib: RestaurentInfoTableViewCell.className)
    }
    
    
    internal func hitRestInfoService(id:String){
        let realm = try! Realm()
        var xLoc = "en"
        if let userInfo = realm.objects(SignupDataModel.self).first{
            //api call kara do
            xLoc = userInfo.xLoc
        }
        
        let header = ["Accept":"application/json",
                      "X-localization":xLoc]
        
        print(header)
        
        if InternetConnection.internetshared.isConnectedToNetwork(){
            self.macroObj.showLoader(view: self.view)
            
            alamoFireObj.getRequestURL("\(MacrosForAll.APINAME.informationrestorent.rawValue)/\(self.id)", headers: header, success: { (resJson) in
                
                if let status = resJson["status"].stringValue as? String{
                    if status == "true"{
                        self.macroObj.hideLoader(view: self.view)
                        print(resJson)
                        if self.reviewDataModelArray.count > 0{
                            self.reviewDataModelArray.removeAll()
                        }
                        if let restorentInfoDict = resJson["restorentInfo"].dictionaryObject as? NSDictionary{
                            if let desc = restorentInfoDict.value(forKey: "description") as? String{
                             //lblDetails.text = "Restaurents Latest Reviews(200+)"
//                                self.lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringPopUP(title: "Description\n", subTitle: "\(desc)\n\n", subTitle2: "Working Hours", delemit: "\n", sizeTitle: 15, sizeSubtitle: 13, titleColor: AppColor.textColor, SubtitleColor: AppColor.placeHolderColor)
                            }
                            if let totolRating = restorentInfoDict.value(forKey: "total_rating") as? Double{
                                
                               
                                self.lblHeader.text = "\(String(format: "%.1f", totolRating)) Ratings"
                                self.viewCosmos.rating = totolRating
                            }
                            
                            
                            if let totalRev = restorentInfoDict.value(forKey: "total_review") as? Int{
                                self.lblDetails.text = "Restaurents Latest Reviews(\(totalRev))"
                                
                            }
                            
                            if let reviewArray = restorentInfoDict.value(forKey: "restorent_review") as? NSArray{
                                for item in reviewArray{
                                    if let timeDict = item as? NSDictionary{
                                        
                                        var user_nameR = String()
                                        
                                        if let user_name = timeDict.value(forKey: "user_name") as? String{
                                            user_nameR = user_name
                                        }
                                        
                                       
                                        guard let rating = timeDict.value(forKey: "rating") as? Double else{
                                            print("no rating")
                                            return
                                        }
                                        
                                        guard let review = timeDict.value(forKey: "review") as? String else{
                                            print("no review")
                                            return
                                        }
                                        
                                        let revItem = RestaurentReviewModel(user_name: user_nameR, rating: rating, review: review)
                                        
                                        self.reviewDataModelArray.append(revItem)
                                        
                                    }
                                }
                                
                                self.tblAddOns.reloadData()                            }
                            
                            
                        }
                        
                    }else{
                        self.macroObj.hideLoader(view: self.view)
                        if let message = resJson["message"].stringValue as? String{
                            _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                        }
                        
                    }
                }
                
            }) { (error) in
                self.macroObj.hideLoader(view: self.view)
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
            }
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            
        }
    }
    
}
