//
//  NotificationsExtensionModel.swift
//  JustBite
//
//  Created by cst on 30/01/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension NotificationsViewController{
    //TODO: Navigation Setup..
    internal  func navigationSetUp(){
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
         super.setupNavigationBarTitle("Notifications", leftBarButtonsType: [.menu], rightBarButtonsType: [])
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer,className:NotificationsViewController.className)
        
       
    }
    
        //TODO: Initial Setup..
        func initialSetUp(){
             notiicationApi()
        }
}



extension NotificationsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NotificationTableViewCell = notificationTV.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
            cell.notiTitle.text = notificationArray[indexPath.row].title
            cell.notiTime.text = notificationArray[indexPath.row].description
         //   cell.notiDesc.text = notificationArray[indexPath.row].time
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension NotificationsViewController{
    func notiicationApi(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            macroObj.showLoader(view: view)
            
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\("Bearer") \(access_token)",
                "Accept":"application/json"]
            
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.Notifications_List.rawValue, headers: header, success: { (responseJASON) in
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                      if let notificationList = responseJASON["notificationList"].arrayObject as? NSArray{
                        for notiItem in notificationList{
                            if let notificationItemDict = notiItem as? NSDictionary{
                                var titleR = String()
                                var descriptionR = String()
                                var typeR = String()
                                var order_idR = String()
                                var res_idR = String()
                                
                                if let title = notificationItemDict.value(forKey: "title") as? String{
                                    titleR = title
                                }
                                
                                if let description = notificationItemDict.value(forKey: "description") as? String{
                                    descriptionR = description
                                }
                                
                                if let type = notificationItemDict.value(forKey: "type") as? String{
                                    typeR = type
                                }
                                
                                if let order_id = notificationItemDict.value(forKey: "order_id") as? String{
                                    order_idR = order_id
                                }
                                
                                if let res_id = notificationItemDict.value(forKey: "res_id") as? String{
                                    res_idR = res_id
                                }
                                
                                let notificationModelItem = Notification_Model(title: titleR, description: descriptionR, type: typeR, order_id: order_idR, res_id: res_idR)
                                
                                self.notificationArray.append(notificationModelItem)
                                
                            }
                        }
                    }
                    self.notificationTV.reloadData()
                    
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
}
