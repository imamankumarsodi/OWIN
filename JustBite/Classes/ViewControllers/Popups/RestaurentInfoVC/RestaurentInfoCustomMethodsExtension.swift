//
//  RestaurentInfoCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import DropDown

extension RestaurentInfoVC{
    //TODO: Initial Setup
    internal func initialStup(){
        self.tblAddOns.tableFooterView = UIView()
        hitRestInfoService(id:self.id)

        topConstraint.constant = MAIN_SCREEN_HEIGHT/2
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewMain, radius: 5)
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        lblHeader.textColor = AppColor.whiteColor
        lblHeader.text = "Restaurant Info"
        header.lblReview.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        header.lblReview.textColor = AppColor.textColor
        header.lblReview.text = "Reviews"
        
       
//        header.btnViewAllRef.setAttributedTitle(GlobalCustomMethods.shared.attributedStringForUnderLine(title: "View All", sizeTitle: 15, titleColor: AppColor.themeColor), for: .normal)
//        
//        
//        header.btnViewAllRef.addTarget(self, action: #selector(self.btnViewAllTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        header.btnShiftRef.addTarget(self, action: #selector(self.btnShiftTapped(sender:)), for: UIControl.Event.touchUpInside)
        
        header.btnShiftRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 16)
        header.btnViewAllRef.titleLabel?.textColor = AppColor.placeHolderColor
        tblAddOns.backgroundView = UIView()
        
        registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblAddOns.register(nib: RestaurentInfoTableViewCell.className)
    }
    
    
    //TODO: Method didScroll
    
    internal func didScrollScrollView(offset: CGFloat){
        let diff = previousOffset - offset
        previousOffset = offset
        
        var newHeight = topConstraint.constant + diff
        print(newHeight)
        
       // let kBarHeight:CGFloat = GlobalCustomMethods.shared.getKbarHeight()
        
        if newHeight < 0{
            newHeight = 0
        } else if newHeight > MAIN_SCREEN_HEIGHT/2 { // or whatever
            newHeight = MAIN_SCREEN_HEIGHT/2
        }
            //For show hide image profile
        else if newHeight > 0{
            
            
        }
        topConstraint.constant = newHeight
    }
    
    internal func convert24To12(Date24:String)->String{
        let dateAsString = Date24
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        let Date12 = dateFormatter.string(from: date!)
        print("12 hour formatted Date:",Date12)
        return Date12
    }
    
    func openDropDown(dataSource:[String]) {
        if dataSource.count > 0{
            header.btnShiftRef.setTitle(dataSource[0], for: .normal)
        }
        self.dropDown.direction = .bottom
        self.dropDown.anchorView = header.btnShiftRef
        self.dropDown.dataSource = self.timeArray
        
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
                
                print(resJson)
                
                if let status = resJson["status"].stringValue as? String{
                    if status == "true"{
                        self.macroObj.hideLoader(view: self.view)
                        print(resJson)
                        if self.reviewDataModelArray.count > 0{
                            self.reviewDataModelArray.removeAll()
                        }
                        if let restorentInfoDict = resJson["restorentInfo"].dictionaryObject as? NSDictionary{
                            if let desc = restorentInfoDict.value(forKey: "description") as? String{
                               self.header.lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringPopUP(title: "Description\n", subTitle: "\(desc)\n\n", subTitle2: "Working Hours", delemit: "\n", sizeTitle: 15, sizeSubtitle: 13, titleColor: AppColor.textColor, SubtitleColor: AppColor.placeHolderColor)
                            }
                            
                            if let restorent_timeArray = restorentInfoDict.value(forKey: "restorent_time") as? NSArray{
                                for item in restorent_timeArray{
                                  /*  if let timeDict = item as? NSDictionary{
                                        guard let open = timeDict.value(forKey: "open_at") as? String else{
                                            print("no open")
                                            return
                                        }
                                        guard let close_at = timeDict.value(forKey: "close_at") as? String else{
                                            print("no close_at")
                                            return
                                        }
                                        
                                        guard let day_name = timeDict.value(forKey: "day_name") as? String else{
                                            print("no day_name")
                                            return
                                        }
                                        
                                        guard let on_status = timeDict.value(forKey: "on_status") as? Int else{
                                            print("no on_status")
                                            return
                                        }
                                         self.timeArray.append("\(self.convert24To12(Date24: open)) - \(self.convert24To12(Date24: close_at))(\(day_name))")
                                         
 
                                        
                                        
                                         }*/
                                    
                                   /* if let timeDict = item as? NSDictionary{
                                        if let timeString = timeDict.value(forKey: "restorent_time") as? String{
                                            self.timeArray.append(timeString)
                                        }
                                    }*/
                                    
                                    
                                    

                                }
                                
                                self.timeArray = restorent_timeArray as? [String] ?? [""]
                                
                                self.openDropDown(dataSource:self.timeArray)
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
                            
                               self.tblAddOns.reloadData()
                                self.tblAddOns.dataSource = self
                                self.tblAddOns.delegate = self
                            }
                            
                            
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
