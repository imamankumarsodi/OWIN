//
//  TopNearByMyFavoriteVCCustomMethodsExtensions.swift
//  JustBite
//
//  Created by Aman on 10/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


//MARK: - Extension Custom methods
extension TopNearByMyFavoriteVC{
    
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        super.hideNavigationBar(false)
        ScreeNNameClass.shareScreenInstance.screenName = TopNearByMyFavoriteVC.className

        registerNib()
        hideKeyboardWhenTappedAround()
        if headertitle == "Top Rated Restaurants"{
            topResService()
        }else if headertitle == "Near-by Restaurants"{
            AccessCurrentLocationuser()
        }else{
            
        }
        self.tblView.addSubview(self.refreshControl)
    
    }
    
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.setupNavigationBarTitle(headertitle, leftBarButtonsType: [.back], rightBarButtonsType: [])
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: TopNearByMyFavoriteVC.className)
        super.transparentNavigation()
        super.hideNavigationBar(false)
        
       
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblView.register(nib: HomeTableViewCell.className)
    }
    
    
    
    
    internal func topResService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
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
            
            
            let passDict = ["user_id":id as AnyObject] as [String:AnyObject]
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.topratedrestorent.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                if self.topResModelArray.count > 0{
                    self.topResModelArray.removeAll()
                }
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let topRatedArr = responseJASON["top_rated"].arrayObject as? NSArray{
                        for topItem in topRatedArr{
                            if let topItemDict = topItem as? NSDictionary{
                                var ratingR = String()
                                var addressR = String()
                                var descriptionR = String()
                                var idR = String()
                                var imgR = String()
                                var is_favoriteR = String()
                                var nameR = String()
                                var reviewR = String()
                                var cuisinesR = [String]()
                                
                                var latitudeR = String()
                                var longitudeR = String()
                                
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
                                
                                if let is_favorite = topItemDict.value(forKey: "is_favorite") as? Int{
                                    is_favoriteR = String(is_favorite)
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
                                
                                let restModelItem = RestaurentDataModelForHome(rating: ratingR, address: addressR, description: descriptionR, id: idR, img: imgR, is_favorite: is_favoriteR, name: nameR, review: reviewR, cuisines: cuisinesR,cuisineString: cuisinesR.joined(separator: ","),min_order_value: Int(), note: String(), discount: Int(), type: Int(), offer_id: Int(), valid_date: String(), thumbnail: String(), res_name: String(), res_address: String(), delivery_time: String(), longitude: longitudeR, latitude: latitudeR,latitudeCur: "\(self.lat)", longitudeCur: "\(self.long)")
                                
                                self.topResModelArray.append(restModelItem)
                            }
                        }
                    }
                    
                    if self.topResModelArray.count > 0{
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
    
    
    
    internal func nearByResService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
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
            
            
            let passDict = ["user_id":id as AnyObject,
                            "latitude":lat,
                            "longitude":long] as [String:AnyObject]
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.nearbyrestorent.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                if self.nearByModelArray.count > 0{
                    self.nearByModelArray.removeAll()
                }
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let topRatedArr = responseJASON["nearBy"].arrayObject as? NSArray{
                        for topItem in topRatedArr{
                            if let topItemDict = topItem as? NSDictionary{
                                var ratingR = String()
                                var addressR = String()
                                var descriptionR = String()
                                var idR = String()
                                var imgR = String()
                                var is_favoriteR = String()
                                var nameR = String()
                                var reviewR = String()
                                var cuisinesR = [String]()
                                
                                var latitudeR = String()
                                var longitudeR = String()
                                
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
                                
                                if let is_favorite = topItemDict.value(forKey: "is_favorite") as? Int{
                                    is_favoriteR = String(is_favorite)
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
                                
                                let restModelItem = RestaurentDataModelForHome(rating: ratingR, address: addressR, description: descriptionR, id: idR, img: imgR, is_favorite: is_favoriteR, name: nameR, review: reviewR, cuisines: cuisinesR,cuisineString: cuisinesR.joined(separator: ","),min_order_value: Int(), note: String(), discount: Int(), type: Int(), offer_id: Int(), valid_date: String(), thumbnail: String(), res_name: String(), res_address: String(), delivery_time: String(), longitude: longitudeR, latitude: latitudeR,latitudeCur: "\(self.lat)", longitudeCur: "\(self.long)")
                                
                                self.nearByModelArray.append(restModelItem)
                            }
                        }
                    }
                    
                    
                    if self.headertitle == "Top Rated Restaurents"{
                        if self.topResModelArray.count > 0{
                            self.tblView.reloadData()
                        }else{
                            self.tblView.reloadData()
                            
                            self.macroObj.showLoaderEmpty(view: self.tblView)
                            self.macroObj.hideLoaderNet(view: self.tblView)
                            self.macroObj.hideWentWrong(view: self.tblView)
                        }
                    }else{
                        if self.nearByModelArray.count > 0{
                            self.tblView.reloadData()
                        }else{
                            self.tblView.reloadData()
                            self.macroObj.showLoaderEmpty(view: self.tblView)
                            self.macroObj.showLoaderEmpty(view: self.tblView)
                            self.macroObj.hideLoaderNet(view: self.tblView)
                            self.macroObj.hideWentWrong(view: self.tblView)
                        }
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
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
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
                    
                    
                    if isFav == "0"{
                        self.macroObj.hideLoaderHeart(view: view)
                        cell.btnFavRef.setImage(#imageLiteral(resourceName: "heart_like_"), for: .normal)
                        
                        if self.headertitle == "Top Rated Restaurents"{
                            self.topResModelArray[index].is_favorite = "1"
                            
                        }else if self.headertitle == "Near-by Restaurents"{
                            self.nearByModelArray[index].is_favorite = "1"
                        }else{
                            
                        }
                        
                        
                        
                    }else{
                        cell.btnFavRef.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                        self.macroObj.hideLoaderBrokenHeart(view: view)
                        if self.headertitle == "Top Rated Restaurents"{
                            self.topResModelArray[index].is_favorite = "0"
                            
                        }else if self.headertitle == "Near-by Restaurents"{
                            self.nearByModelArray[index].is_favorite = "0"
                        }else{
                            
                        }
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
