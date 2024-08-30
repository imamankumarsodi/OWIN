//
//  SearchCustomMethodsExtensios.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension SearchVC:VCFinalDelegateBackToSearch{
   
    
    func finishPassing(vegstatus: String, nonvgstatus: String, price: String, rate: String, cuisineId: String) {
        print("api hit kara do")
        favResFilterService(vegstatus: vegstatus,nonvgstatus: nonvgstatus, price: price, rate: rate, cuisineId: cuisineId)
    }
    
    
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        ScreeNNameClass.shareScreenInstance.screenName = SearchVC.className

        search_bar.delegate = self
        super.hideNavigationBar(false)
        self.viewSearch.backgroundColor = AppColor.whiteColor
        self.search_bar.placeholder = "Search by Restaurants, Dishes, Cusines"
        self.search_bar.backgroundImage = UIImage()
        
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        lblHeader.textColor = AppColor.textColor
        lblHeader.text = "Restaurants"
        
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: self.viewSearch)
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewSearch, radius: self.viewSearch.frame.size.height/2)
        
        registerNib()
        hideKeyboardWhenTappedAround()
        self.tblView.addSubview(self.refreshControl)
        AccessCurrentLocationuser()
        
    }
    
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.setupNavigationBarTitle("Search", leftBarButtonsType: [.menu], rightBarButtonsType: [.cart])
        
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: SearchVC.className)
        super.transparentNavigation()
        super.hideNavigationBar(false)
        
        
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblView.register(nib: HomeTableViewCell.className)
    }
    
    
    internal func favResService(){
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
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.searchrestorent.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                if self.favModelArray.count > 0{
                    self.favModelArray.removeAll()
                    
                }
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let topRatedArr = responseJASON["search"].arrayObject as? NSArray{
                        for topItem in topRatedArr{
                            if let topItemDict = topItem as? NSDictionary{
                                var ratingR = String()
                                var addressR = String()
                                var descriptionR = String()
                                var idR = String()
                                var imgR = String()
                                var is_favoriteR = "1"
                                var nameR = String()
                                var reviewR = String()
                                var cuisinesR = [String]()
                                var cuisinesRR = [String]()
                                var longitudeR = String()
                                var latitudeR = String()
                                
                                if let rating = topItemDict.value(forKey: "rating") as? Double{
                                    ratingR = String(rating)
                                }
                                
                                if let is_favorite = topItemDict.value(forKey: "is_favorite") as? Int{
                                    print(is_favorite)
                                    is_favoriteR = String(is_favorite)
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
                                    cuisinesR.removeAll()
                                    self.cuisinesIdArray.removeAll()
                                    self.cuisinesNameArray.removeAll()
                                    for cusine in  cuisines{
                                        if let cusineDict = cusine as? NSDictionary{
                                            if let name = cusineDict.value(forKey: "name") as? String{
                                                cuisinesR.append(name)
                                                self.cuisinesNameArray.append(name)
                                            }
                                            
                                            if let id = cusineDict.value(forKey: "id") as? Int{
                                                self.cuisinesIdArray.append(id)
                                            }
                                        }
                                    }
                                }
                                
                                
                                if let menu = topItemDict.value(forKey: "menu") as? NSArray{
                                    cuisinesRR.removeAll()
                                    self.cuisinesIdArray.removeAll()
                                    self.cuisinesNameArray.removeAll()
                                    for cusine in  menu{
                                        if let cusineDict = cusine as? NSDictionary{
                                            if let name = cusineDict.value(forKey: "en_name") as? String{
                                                cuisinesRR.append(name)
                                                self.cuisinesNameArray1.append(name)
                                            }
                                            
                                            if let id = cusineDict.value(forKey: "id") as? Int{
                                                self.cuisinesIdArray1.append(id)
                                            }
                                        }
                                    }
                                }
                                
                                
                                let restModelItem = RestaurentDataModelForHome(rating:ratingR, address: addressR, description: descriptionR, id: idR, img: imgR, is_favorite: is_favoriteR, name: nameR, review: reviewR, cuisines: cuisinesR, cuisineString: cuisinesR.joined(separator: "~"),min_order_value: Int(), note: cuisinesRR.joined(separator: "~"), discount: Int(), type: Int(), offer_id: Int(), valid_date: String(), thumbnail: String(), res_name: String(), res_address: String(), delivery_time: String(), longitude: longitudeR, latitude: latitudeR,latitudeCur: "\(self.lat)", longitudeCur: "\(self.long)")
                                
                                self.favModelArray.append(restModelItem)
                            }
                        }
                    }
                    
                    if self.favModelArray.count > 0{
                        self.tblView.reloadData()
                    }else{
                        self.tblView.reloadData()
                       // self.macroObj.showLoaderEmpty(view: self.tblView)
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
    
    
    
    internal func favResFilterService(vegstatus: String,nonvgstatus: String, price: String, rate: String, cuisineId: String){
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
            
            print(header)
            
//            price:122
//            is_veg:1
//            is_non_veg:
//            rating:4
//            cuisine:2
            let passDict = ["price":price as AnyObject,
                            "rating":rate,
                            "cuisine":cuisineId,
                            "is_veg":vegstatus,
                            "is_non_veg":nonvgstatus] as [String:AnyObject]
           
            
            print(passDict)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.filterrestorent.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                if self.favModelArray.count > 0{
                    self.favModelArray.removeAll()
                    
                }
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let topRatedArr = responseJASON["filter"].arrayObject as? NSArray{
                        for topItem in topRatedArr{
                            if let topItemDict = topItem as? NSDictionary{
                                var ratingR = String()
                                var addressR = String()
                                var descriptionR = String()
                                var idR = String()
                                var imgR = String()
                                var is_favoriteR = "1"
                                var nameR = String()
                                var reviewR = String()
                                var cuisinesR = [String]()
                                var cuisinesRR = [String]()
                                
                                var longitudeR = String()
                                var latitudeR = String()
                                
                                
                                if let rating = topItemDict.value(forKey: "rating") as? Double{
                                    ratingR = String(rating)
                                }
                                
                                if let address = topItemDict.value(forKey: "address") as? String{
                                    addressR = address
                                }
                                
                                if let is_favorite = topItemDict.value(forKey: "is_favorite") as? Int{
                                    print(is_favorite)
                                    is_favoriteR = String(is_favorite)
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
                                    cuisinesR.removeAll()
                                    self.cuisinesIdArray.removeAll()
                                    self.cuisinesNameArray.removeAll()
                                    for cusine in  cuisines{
                                        if let cusineDict = cusine as? NSDictionary{
                                            if let name = cusineDict.value(forKey: "name") as? String{
                                                cuisinesR.append(name)
                                                self.cuisinesNameArray.append(name)
                                            }
                                            
                                            if let id = cusineDict.value(forKey: "id") as? Int{
                                                self.cuisinesIdArray.append(id)
                                            }
                                        }
                                    }
                                }
                                
                                
                                if let menu = topItemDict.value(forKey: "menu") as? NSArray{
                                    cuisinesRR.removeAll()
                                    self.cuisinesIdArray.removeAll()
                                    self.cuisinesNameArray.removeAll()
                                    for cusine in  menu{
                                        if let cusineDict = cusine as? NSDictionary{
                                            if let name = cusineDict.value(forKey: "en_name") as? String{
                                                cuisinesRR.append(name)
                                                self.cuisinesNameArray1.append(name)
                                            }
                                            
                                            if let id = cusineDict.value(forKey: "id") as? Int{
                                                self.cuisinesIdArray1.append(id)
                                            }
                                        }
                                    }
                                }
                                
                                
                                let restModelItem = RestaurentDataModelForHome(rating:ratingR, address: addressR, description: descriptionR, id: idR, img: imgR, is_favorite: is_favoriteR, name: nameR, review: reviewR, cuisines: cuisinesR, cuisineString: cuisinesR.joined(separator: "~"),min_order_value: Int(), note: cuisinesRR.joined(separator: "~"), discount: Int(), type: Int(), offer_id: Int(), valid_date: String(), thumbnail: String(), res_name: String(), res_address: String(), delivery_time: String(), longitude: longitudeR, latitude: latitudeR,latitudeCur: "\(self.lat)", longitudeCur: "\(self.long)")
                                
                                self.favModelArray.append(restModelItem)
                            }
                        }
                    }
                    
                    if self.favModelArray.count > 0{
                        self.tblView.reloadData()
                    }else{
                        self.tblView.reloadData()
                       // self.macroObj.showLoaderEmpty(view: self.tblView)
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
                    
                    
                    
                    if isFav == "0"{
                        cell.btnFavRef.setImage(#imageLiteral(resourceName: "heart_like_"), for: .normal)
                        
                        self.macroObj.hideLoaderHeart(view: view)
                        self.favModelArray[index].is_favorite = "1"
                    }else{
                        cell.btnFavRef.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                        
                        self.macroObj.hideLoaderBrokenHeart(view: view)
                        self.favModelArray[index].is_favorite = "0"
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


// MARK: - Search extensions

extension SearchVC:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            searchActive = false
        }else{
            searchActive = true
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.search_bar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if filtered.count > 0{
            filtered.removeAll()
        }
        if searchBar.text!.isEmpty {
            searchActive = false
        }
        else {
            searchActive = true
            if favModelArray.count >= 1 {
                for index in 0...favModelArray.count - 1 {
                    if let dictResponse = favModelArray[index] as? RestaurentDataModelForHome{
                        
                        guard let restName = dictResponse.name as? String else{
                            print("No restName")
                            return
                        }
                        guard let cuisName = dictResponse.cuisineString as? String else{
                            print("No cuisName")
                            return
                        }
                        
                        guard let dishName = dictResponse.note as? String else{
                            print("No dishName")
                            return
                        }
                        
                        
                        if (restName.lowercased().range(of: searchText.lowercased()) != nil)||(cuisName.lowercased().range(of: searchText.lowercased()) != nil)||(dishName.lowercased().range(of: searchText.lowercased()) != nil) {
                            filtered.append(dictResponse)
                        }
                    }
                }
            }
        }
        tblView.reloadData()
    }
}
