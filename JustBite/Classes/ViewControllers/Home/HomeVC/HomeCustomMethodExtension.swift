//
//  HomeCustomMethodExtension.swift
//  JustBite
//
//  Created by Aman on 09/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import GooglePlaces
import GoogleMaps

extension HomeVC{
    internal func initialSetup(){
        
        updateUI()
       // AccessCurrentLocationuser()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        hideKeyboardWhenTappedAround()
        ScreeNNameClass.shareScreenInstance.screenName = HomeVC.className

        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        gradientLayer.frame = self.viewHeader.bounds
        
        self.viewHeader.layer.insertSublayer(gradientLayer, at:0)
        
       // super.setupNavigationBarTitle("Home", leftBarButtonsType: [], rightBarButtonsType: [])
        self.txtFieldHeader.textColor = AppColor.whiteColor
        self.tblViewHome.addSubview(self.refreshControl)
        self.registerNib()
        self.registerNibCol()
        self.tblViewHome.tableFooterView = UIView()
        
        
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        ConstantTexts.screenName = HomeVC.className
        super.transparentNavigation()
        super.hideNavigationBar(true)
      
    }
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblViewHome.register(nib: HomeMainTableViewCell.className)
    }
    
    //TODO: Register Nib method
    fileprivate func registerNibCol(){
//        self.collectionView.registerMultiple(nibs: [HomeCollectionViewCellAvailableOffer.className,HomeCollectionViewCellDetail.className])
    }
    
    internal func homeService(){
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
                            "latitude":self.lat,
                            "longitude":self.long] as [String:AnyObject]
            print(passDict)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.restorentlist.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                if self.topResModelArray.count > 0{
                  self.topResModelArray.removeAll()
                }
                if self.nearByModelArray.count > 0{
                    self.nearByModelArray.removeAll()
                }
                
                if self.OffersDataModelArray.count > 0{
                    self.OffersDataModelArray.removeAll()
                }
                
                if self.homeListModelArray.count > 0{
                    self.homeListModelArray.removeAll()
                }
                
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    self.locationManager.delegate = nil
                    
                    if let dataDict = responseJASON["homeList"].dictionaryObject as NSDictionary?{
                        for (key, array) in dataDict
                        {
                            if let keyString = key as? String{
                                if keyString == "nearBy"{
                                    if self.nearByModelArray.count > 0{
                                        self.nearByModelArray.removeAll()
                                    }
                                    
                                    if let nearByArray = array as? NSArray{
                                        for nearByItem in nearByArray{
                                            if let nearByItemDict = nearByItem as? NSDictionary{
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
                                                
                                                if let rating = nearByItemDict.value(forKey: "rating") as? Double{
                                                    ratingR = String(rating)
                                                }
                                                
                                                if let address = nearByItemDict.value(forKey: "address") as? String{
                                                    addressR = address
                                                }
                                                
                                                if let description = nearByItemDict.value(forKey: "description") as? String{
                                                    descriptionR = description
                                                }
                                                
                                                if let id = nearByItemDict.value(forKey: "id") as? Int{
                                                    idR = String(id)
                                                }
                                                
                                                if let img = nearByItemDict.value(forKey: "img") as? String{
                                                    imgR = img
                                                }
                                                
                                                if let is_favorite = nearByItemDict.value(forKey: "is_favorite") as? Int{
                                                    is_favoriteR = String(is_favorite)
                                                }
                                                
                                                if let name = nearByItemDict.value(forKey: "name") as? String{
                                                    nameR = name
                                                }
                                                
                                                if let review = nearByItemDict.value(forKey: "review") as? Int{
                                                    reviewR = String(review)
                                                }
                                                
                                                if let longitude = nearByItemDict.value(forKey: "longitude") as? String{
                                                    longitudeR         = String(longitude)
                                                }
                                                
                                                if let latitude = nearByItemDict.value(forKey: "latitude") as? String{
                                                  latitudeR   = String(latitude)
                                                }
                                                
                                                if let cuisines = nearByItemDict.value(forKey: "cuisines") as? NSArray{
                                                    for cusine in  cuisines{
                                                        if let cusineDict = cusine as? NSDictionary{
                                                            if let name = cusineDict.value(forKey: "name") as? String{
                                                                cuisinesR.append(name)
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                                let restModelItem = RestaurentDataModelForHome(rating: ratingR, address: addressR, description: descriptionR, id: idR, img: imgR, is_favorite: is_favoriteR, name: nameR, review: reviewR, cuisines: cuisinesR,cuisineString: cuisinesR.joined(separator: ","), min_order_value: Int(), note: String(), discount: Int(), type: Int(), offer_id: Int(), valid_date: String(), thumbnail: String(), res_name: String(), res_address: String(), delivery_time: String(), longitude: longitudeR, latitude: latitudeR,latitudeCur: "\(self.lat)", longitudeCur: "\(self.long)")
                                                
                                                self.nearByModelArray.append(restModelItem)
                                            }
                                        }
                                    }
                                    
                                    
                                }else if keyString == "top_rated"{
                                    if self.topResModelArray.count > 0{
                                        self.topResModelArray.removeAll()
                                    }
                                    if let topArray = array as? NSArray{
                                        for topItem in topArray{
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
                                                
                                                
                                                UserDefaults.standard.set(self.lat, forKey: "latitude")
                                                UserDefaults.standard.set(self.long, forKey: "longitude")
                                                
                                                self.topResModelArray.append(restModelItem)
                                            }
                                        }
                                    }
                                    
                                }else{
//                                    "valid_date" : "2019-07-24",
//                                    "type" : 2,
//                                    "discount" : null,
//                                    "min_order_value" : 2,
//                                    "restorent_id" : 8,
//                                    "res_address" : "Sector 62, Noida, Uttar Pradesh, India",
//                                    "note" : "Buy one Large Pizza and get one Large Pizza FREE :)",
//                                    "id" : 10,
//                                    "delivery_time" : "50",
//                                    "res_name" : "Maharaja Restaurant",
//                                    "thumbnail" : "http:\/\/3.8.172.240\/just_bite\/public\/storage\/offer\/thumbnail\/1562147715_buy1.png"
                                    
                                    
                                    
                                    if self.OffersDataModelArray.count > 0{
                                        self.OffersDataModelArray.removeAll()
                                    }
                                    if let topArray = array as? NSArray{
                                        for topItem in topArray{
                                            if let topItemDict = topItem as? NSDictionary{
                                                
                                                var min_order_valueR = Int()
                                                var noteR = String()
                                                var discountR = Int()
                                                var typeR = Int()
                                                var offer_idR = Int()
                                                var valid_dateR = String()
                                                var thumbnailR = String()
                                                var res_nameR = String()
                                                var res_addressR = String()
                                                var delivery_timeR = String()
                                                var idR = String()
                                                var latitudeR = String()
                                                var longitudeR = String()
                                                
                                                
                                                if let min_order_value = topItemDict.value(forKey: "min_order_value") as? Int{
                                                    min_order_valueR = min_order_value
                                                }
                                                
                                                if let note = topItemDict.value(forKey: "note") as? String{
                                                    noteR = note
                                                }
                                                
                                                if let discount = topItemDict.value(forKey: "discount") as? Int{
                                                    discountR = discount
                                                }
                                                
                                                if let id = topItemDict.value(forKey: "id") as? Int{
                                                    offer_idR = id
                                                }
                                                
                                                if let restorent_id = topItemDict.value(forKey: "restorent_id") as? Int{
                                                    idR = String(restorent_id)
                                                }
                                                
                                                if let type = topItemDict.value(forKey: "type") as? Int{
                                                    typeR = type
                                                }
                                                
                                                if let valid_date = topItemDict.value(forKey: "valid_date") as? String{
                                                    valid_dateR = String(valid_date)
                                                }
                                                
                                                if let thumbnail = topItemDict.value(forKey: "thumbnail") as? String{
                                                    thumbnailR = thumbnail
                                                }
                                                
                                                if let res_address = topItemDict.value(forKey: "res_address") as? String{
                                                    res_addressR = res_address
                                                }
                                                
                                                if let res_name = topItemDict.value(forKey: "res_nameR") as? String{
                                                    res_nameR = String(res_name)
                                                }
                                                
                                                if let delivery_time = topItemDict.value(forKey: "delivery_time") as? String{
                                                    delivery_timeR = delivery_time
                                                }

                                                if let longitude = topItemDict.value(forKey: "longitude") as? String{
                                                    longitudeR         = String(longitude)
                                                }
                                                
                                                if let latitude = topItemDict.value(forKey: "latitude") as? String{
                                                    latitudeR   = String(latitude)
                                                }
                                               
                                                
                                                let restModelItem = RestaurentDataModelForHome(rating: String(), address: res_addressR, description: noteR, id: idR, img: thumbnailR, is_favorite: String(), name: res_nameR, review: String(), cuisines: [String](), cuisineString: String(), min_order_value: min_order_valueR, note: noteR, discount: discountR, type: typeR, offer_id: offer_idR, valid_date: valid_dateR, thumbnail: thumbnailR, res_name: res_nameR, res_address: res_addressR, delivery_time: delivery_timeR, longitude: longitudeR, latitude: latitudeR, latitudeCur: "\(self.lat)", longitudeCur: "\(self.long)")
                                                
                                                self.OffersDataModelArray.append(restModelItem)
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    self.homeListModelArray.append(HomeListingModel(HomeListingArr: self.OffersDataModelArray))
                    self.homeListModelArray.append(HomeListingModel(HomeListingArr: self.topResModelArray))
                    self.homeListModelArray.append(HomeListingModel(HomeListingArr: self.nearByModelArray))
                    print(self.homeListModelArray.count)
                    self.tblViewHome.reloadData()
                
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
    
    
    
    
    func reverseGeocodeCoordinate(inLat:Double, inLong:Double) {
        
        let cordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: inLat, longitude: inLong)
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(cordinate) { response, error in
            
            if let address = response?.results() {
                
                let lines = address.first
                
                print(lines)
                
                if let addressNew = lines?.lines {
                    
                    self.txtFieldHeader.text = self.makeAddressString(inArr: addressNew)
//                    self.area = lines?.locality ?? ""
//                    self.pincode = lines?.postalCode ?? ""
//                    self.landmark = lines?.administrativeArea ?? ""
                    
                    //                    self.strAddress = self.makeAddressString(inArr: addressNew)
                    //
                    //                    self.lblAddress.text = self.strAddress
                    //
                    //                    print(self.strAddress)
                    //                    self.configureMap()
                    //
                    //                    self.dropMapPin()
                    
                    //                    self.txtAddress.text = self.makeAddressString(inArr: addressNew)
//                                       self.search_bar.text = self.makeAddressString(inArr: addressNew)
//                                       self.address = self.makeAddressString(inArr: addressNew)
                    //
                    //                    print(lines?.country ?? "")
                    //                    print(lines?.postalCode ?? "")
                    //                    print(lines?.administrativeArea ?? "")
                    //                    print(lines?.locality ?? "")
                    //                    print(lines?.subLocality ?? "")
                    //
                    //                    self.country = lines?.country ?? ""
                    //                    self.state = lines?.administrativeArea ?? ""
                    //                    self.city = lines?.locality ?? ""
                    //                    self.zipCode = lines?.postalCode ?? ""
                    //                    self.locality = lines?.subLocality ?? ""
                    
                }
            }
        }
    }
    
    
    func makeAddressString(inArr:[String]) -> String {
        
        var fVal:String = ""
        for val in inArr {
            
            fVal =  fVal + val + " "
            
        }
        return fVal
        
    }
}
