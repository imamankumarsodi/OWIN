//
//  MyFavoriteCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 19/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


//MARK: - Extension Custom methods
extension MyFavroiteVC{
    
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        ScreeNNameClass.shareScreenInstance.screenName = MyFavroiteVC.className

      //  super.hideNavigationBar(false)
        self.tblView.addSubview(self.refreshControl)
        registerNib()
        hideKeyboardWhenTappedAround()
        favResService()
        
    }
    
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
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
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: MyFavroiteVC.className)
        super.setupNavigationBarTitle("My Favorites", leftBarButtonsType: [.menu], rightBarButtonsType: [])
       
        
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblView.register(nib: HomeTableViewCell.className)
    }
    
    
    internal func favResService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let realm = try! Realm()
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
            macroObj.showLoader(view: view)
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.userfavourite.rawValue, headers: header, success: { (responseJASON) in
                
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                if self.favModelArray.count > 0{
                    self.favModelArray.removeAll()
                }
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let topRatedArr = responseJASON["favourite"].arrayObject as? NSArray{
                        for topItem in topRatedArr{
                            if let topItemDict = topItem as? NSDictionary{
                                var ratingR = String()
                                var addressR = String()
                                var descriptionR = String()
                                var idR = String()
                                var imgR = String()
                                let is_favoriteR = "1"
                                var nameR = String()
                                var reviewR = String()
                                var cuisinesR = [String]()
                                var longitudeR = String()
                               var latitudeR = String()
                                
                                if let rating = topItemDict.value(forKey: "rating") as? Double{
                                    ratingR = String(rating)
                                }
                                
                                if let address = topItemDict.value(forKey: "address") as? String{
                                    addressR = address
                                }
                                
                                if let description = topItemDict.value(forKey: "description") as? String{
                                    descriptionR = description
                                }
                                
                                if let id = topItemDict.value(forKey: "id") as? Int{
                                    idR = String(id)
                                }
                                
                                if let img = topItemDict.value(forKey: "img") as? String{
                                    imgR = img
                                }
                                
                                
                                if let name = topItemDict.value(forKey: "name") as? String{
                                    nameR = name
                                }
                                
                                if let review = topItemDict.value(forKey: "review") as? Int{
                                    reviewR = String(review)
                                }
                                
                                if let longitude = topItemDict.value(forKey: "longitude") as? String{
                                    longitudeR         = String(longitude)
                                }
                                
                                if let latitude = topItemDict.value(forKey: "latitude") as? String{
                                    latitudeR   = String(latitude)
                                }
                                
                                if let cuisines = topItemDict.value(forKey: "cuisines") as? NSArray{
                                    for cusine in  cuisines{
                                        if let cusineDict = cusine as? NSDictionary{
                                            if let name = cusineDict.value(forKey: "name") as? String{
                                                cuisinesR.append(name)
                                            }
                                        }
                                    }
                                }
                                
                                let restModelItem = RestaurentDataModelForHome(rating: ratingR, address: addressR, description: descriptionR, id: idR, img: imgR, is_favorite: is_favoriteR, name: nameR, review: reviewR, cuisines: cuisinesR,cuisineString: cuisinesR.joined(separator: ","),min_order_value: Int(), note: String(), discount: Int(), type: Int(), offer_id: Int(), valid_date: String(), thumbnail: String(), res_name: String(), res_address: String(), delivery_time: String(), longitude: longitudeR, latitude: latitudeR, latitudeCur:"\(self.gotLat)", longitudeCur: "\(self.gorLong)")
                                
                                self.favModelArray.append(restModelItem)
                                
                                print("fav model array count is-->",self.favModelArray)
                            }
                        }
                    }
                    
                    if self.favModelArray.count > 0{
                        self.tblView.reloadData()
                    }else{
                        self.tblView.reloadData()
                        self.macroObj.showLoaderEmpty(view: self.tblView)
                        self.macroObj.hideLoaderNet(view: self.tblView)
                        self.macroObj.hideWentWrong(view: self.tblView)
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
                self.macroObj.showWentWrong(view: self.tblView)
                self.macroObj.hideLoaderEmpty(view: self.tblView)
                self.macroObj.hideLoaderNet(view: self.tblView)
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblView)
            macroObj.hideLoaderEmpty(view: self.tblView)
            macroObj.hideWentWrong(view: self.tblView)
        }
    }
    
    internal func addFavService(token_type:String,access_token:String,view:UIView,id:String,isFav:String,index:Int,cell:HomeTableViewCell){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["restaurant_id":id,
                            "is_favourite":isFav] as [String : AnyObject]
            
            print(passDict)
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
            print(header)
            
            if isFav == "0"{
                macroObj.showLoaderHeart(view: view)
            }else{
                //toote dil ka chala do
                macroObj.showLoaderBrokenHeart(view: view)
            }
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.savefavourite.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    
                    
                   
                        cell.btnFavRef.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                        self.macroObj.hideLoaderBrokenHeart(view: view)
                        self.favModelArray.remove(at: index)
                    
                    if self.favModelArray.count > 0{
                       self.tblView.reloadData()
                    }else{
                        self.tblView.reloadData()
                        self.macroObj.showLoaderEmpty(view: self.tblView)
                        self.macroObj.hideLoaderNet(view: self.tblView)
                        self.macroObj.hideWentWrong(view: self.tblView)
                    }
                    
    
                    
                    
                    
                }else{
                    if isFav == "0"{
                        self.macroObj.hideLoaderHeart(view: view)
                    }else{
                        self.macroObj.hideLoaderBrokenHeart(view: view)
                    }
                    
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                    
                }
                
            }, failure: { (error) in
                if isFav == "0"{
                    self.macroObj.hideLoaderHeart(view: view)
                }else{
                    self.macroObj.hideLoaderBrokenHeart(view: view)
                }
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
                self.macroObj.showWentWrong(view: self.tblView)
                self.macroObj.hideLoaderEmpty(view: self.tblView)
                self.macroObj.hideLoaderNet(view: self.tblView)
            })
            
        }else{
            if isFav == "0"{
                self.macroObj.hideLoaderHeart(view: view)
            }else{
                self.macroObj.hideLoaderBrokenHeart(view: view)
            }
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblView)
            macroObj.hideLoaderEmpty(view: self.tblView)
            macroObj.hideWentWrong(view: self.tblView)
        }
    }
}
