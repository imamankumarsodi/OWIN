//
//  RestaurentDetailsCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 13/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


extension RestaurentDetailsVC:VCFinalDelegate{
    func finishPassing(status: String, price: String) {
        
       print(status)
    print(price)
        self.filterService(catId:categoryDataModelArray[index].id,type:categoryDataModelArray[index].type, item_type: status, price: price,index:index)
    }
    
    func backDataToDetilsReloadFilter(itemtype: String, taste: String, eatType: String) {
        print(itemtype)
        print(taste)
        print(eatType)
        print(index)
        self.FilterService(catId: categoryDataModelArray[index].id, type: categoryDataModelArray[index].type, item_type: itemtype, taste: taste, eat_type: eatType,index:index)
    
    }
    
    //TODO: Inititial Setup
    internal func initialSetup(){
        ScreeNNameClass.shareScreenInstance.screenName = RestaurentDetailsVC.className

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        reviewsRef.isUserInteractionEnabled = true
        reviewsRef.addGestureRecognizer(tap)
        GlobalCustomMethods.shared.provideCornarRadius(btnRef: self.viewLike)
        
        self.btnConfirmRef.backgroundColor = AppColor.stepperColor
        self.btnConfirmRef.setTitle("Add to Cart", for: .normal)
        self.btnConfirmRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        self.tblCart.addSubview(self.refreshControl)
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.isHidden = true
        self.btnCancelSearchRef.isHidden = true
        registerNib()
        registerNibCollection()
        loadOrders()
        ResDetailService()
    }
    
    //TODO: Setup Navigation
    internal func navigationSetup(){
        preferredStatusBarStyle
        super.transparentNavigation()
        super.hideNavigationBar(true)
        registerNib()
    }
    
    
    //TODO: Method didScroll
    internal func didScrollScrollView(offset: CGFloat){
        let diff = previousOffset - offset
        previousOffset = offset
        var newHeight = heightConstraints.constant + diff
        print(newHeight)
        let kBarHeight:CGFloat = GlobalCustomMethods.shared.getKbarHeight()
        if newHeight < kBarHeight {
            newHeight = kBarHeight
        } else if newHeight > 227 { // or whatever
            newHeight = 227
        }
            //For show hide image profile
        else if newHeight > kBarHeight{
        }
        heightConstraints.constant = newHeight
    }
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblCart.register(nib: CartTableViewCellAndXib.className)
    }
    
    //TODO: Register Nib method
    fileprivate func registerNibCollection(){
        self.collectionViewHeader.register(nib: CartCollectionViewCellAndXib.className)
    }

    
    //TODO: Call add cart method
    internal func calladdCartMethod(index:Int,isComing:Bool,userType:String){
        
        if searchActive{
            if self.filterMenuDataArray[index].customizeDataModelArray.count > 0{
                /*  let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: SubMenuListingVC.className) as! SubMenuListingVC
                 viewC.customizeDataModelArray = self.filterMenuDataArray[index].customizeDataModelArray
                 viewC.price = self.filterMenuDataArray[index].price
                 viewC.quantity = self.filterMenuDataArray[index].quantity
                 
                 viewC.index = index
                 viewC.backObj = self
                 viewC.userType = userType
                 viewC.isComing = "REST"
                 viewC.catIndex = self.catIndex
                 if isComing{
                 viewC.isNewOrder = "1"
                 }else{
                 viewC.isNewOrder = ""
                 }
                 self.navigationController?.present(viewC, animated: true, completion: nil) */
                
                
                
                // isko mat chedna
                var isNewOrder = String()
                if isComing{
                    isNewOrder = "1"
                }else{
                    isNewOrder = ""
                }
                var qty = self.filterMenuDataArray[index].quantity
                qty += 1
                self.addToCart(catId:String(self.categoryDataModelArray[self.index].id),type:String(self.categoryDataModelArray[self.index].type),index:index,qty:qty,price:Double(self.filterMenuDataArray[index].price),newOreder:isNewOrder,menu_id:String(self.filterMenuDataArray[index].id),addon:String(), status: "plus")
                
                
                
            }else{
                // isko mat chedna
                var isNewOrder = String()
                if isComing{
                    isNewOrder = "1"
                }else{
                    isNewOrder = ""
                }
                var qty = self.filterMenuDataArray[index].quantity
                qty += 1
                self.addToCart(catId:String(self.categoryDataModelArray[self.index].id),type:String(self.categoryDataModelArray[self.index].type),index:index,qty:qty,price:Double(self.filterMenuDataArray[index].price),newOreder:isNewOrder,menu_id:String(self.filterMenuDataArray[index].id),addon:String(), status: "plus")
                
            }
            
            
            
            
        }else{
            if self.menuItemDataModelArray[index].customizeDataModelArray.count > 0{
                /*  let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: SubMenuListingVC.className) as! SubMenuListingVC
                 viewC.customizeDataModelArray = self.menuItemDataModelArray[index].customizeDataModelArray
                 viewC.price = self.menuItemDataModelArray[index].price
                 viewC.quantity = self.menuItemDataModelArray[index].quantity
                 
                 viewC.index = index
                 viewC.backObj = self
                 viewC.userType = userType
                 viewC.isComing = "REST"
                 viewC.catIndex = self.catIndex
                 if isComing{
                 viewC.isNewOrder = "1"
                 }else{
                 viewC.isNewOrder = ""
                 }
                 self.navigationController?.present(viewC, animated: true, completion: nil) */
                
                // isko mat chedna
                var isNewOrder = String()
                if isComing{
                    isNewOrder = "1"
                }else{
                    isNewOrder = ""
                }
                var qty = self.menuItemDataModelArray[index].quantity
                qty += 1
                self.addToCart(catId:String(self.categoryDataModelArray[self.index].id),type:String(self.categoryDataModelArray[self.index].type),index:index,qty:qty,price:Double(self.menuItemDataModelArray[index].price),newOreder:isNewOrder,menu_id:String(self.menuItemDataModelArray[index].id),addon:String(), status: "plus")
                
            }else{
                // isko mat chedna
                var isNewOrder = String()
                if isComing{
                    isNewOrder = "1"
                }else{
                    isNewOrder = ""
                }
                var qty = self.menuItemDataModelArray[index].quantity
                qty += 1
                self.addToCart(catId:String(self.categoryDataModelArray[self.index].id),type:String(self.categoryDataModelArray[self.index].type),index:index,qty:qty,price:Double(self.menuItemDataModelArray[index].price),newOreder:isNewOrder,menu_id:String(self.menuItemDataModelArray[index].id),addon:String(), status: "plus")
                
            }
        }
        
        
        
    }
    
    
    
    
    //TODO: Restorent detail service
    internal func ResDetailService(){
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
            alamoFireObj.postRequestFormDataURL("\(MacrosForAll.APINAME.detailrestorent.rawValue)/\(self.id)", params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let detailsRestorent = responseJASON["detailsRestorent"].dictionaryObject as? NSDictionary{
                        
                        if self.categoryDataModelArray.count > 0{
                            self.categoryDataModelArray.removeAll()
                        }
                        
                        var cuisinesR = [String]()
                        var nameR = String()
                        var ratingR = String()
                        
                        
                        if let restorentLat = detailsRestorent.value(forKey: "restorentLat") as? String{
                            self.restaurentLat = restorentLat
            
                        }
                        
                        
                        if let restorentLong = detailsRestorent.value(forKey: "restorentLong") as? String{
                            self.restaurentLong = restorentLong
                        }
                        
                        
                        
                        if let address = detailsRestorent.value(forKey: "address") as? String{
                            
                            self.lblAddress.attributedText = GlobalCustomMethods.shared.updateRestaurentAddressLabel(address: address)
                            
                            self.restaurentAddress = address
                        }
                        
                        
                        if let delivery_time = detailsRestorent.value(forKey: "delivery_time") as? String{
                            
                            self.lblDeliveryTime.text = "\(delivery_time) mins."
                        }
                        
                        if let min_order_value = detailsRestorent.value(forKey: "min_order_value") as? Double{
                            self.lblMinOrder.text = "Min. Order : AED \(Double(min_order_value) ?? 0.0)"
                            
                        }
                        
                        
                        if let name = detailsRestorent.value(forKey: "name") as? String{
                            nameR = name
                            self.restaurentName = name
                        }
                        
                        if let cart_value = detailsRestorent.value(forKey: "cart_value") as? Int{
                            
                            self.cart_value = cart_value
                            if self.cart_value != 0{
                                self.btnConfirmRef.isHidden = false
                                self.heigntConsBtn.constant = 60
                            }else{
                                self.btnConfirmRef.isHidden = true
                                self.heigntConsBtn.constant = 0
                            }
                        }
                        
                        
                        
                        let realm = try! Realm()
                        if let userInfo = realm.objects(OrderItem.self).first{
                            self.btnConfirmRef.isHidden = false
                            self.heigntConsBtn.constant = 60
                        }else{
                            self.btnConfirmRef.isHidden = false
                            self.heigntConsBtn.constant = 60
                        }

                        
                        
                        
                        
                        if let cuisines = detailsRestorent.value(forKey: "cuisines") as? NSArray{
                            for cusine in  cuisines{
                                if let cusineDict = cusine as? NSDictionary{
                                    if let name = cusineDict.value(forKey: "name") as? String{
                                        cuisinesR.append(name)
                                    }
                                }
                            }
                        }
                        
                        if let image = detailsRestorent.value(forKey: "image") as? String{
                            self.imgRestaurent.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "user_signup"))
                        }
                        
                        self.lblDetails.attributedText = GlobalCustomMethods.shared.updateRestaurentDetails(title: nameR, cusineArray: cuisinesR,  delemit: "\n")
                        
                        
                        if let rating = detailsRestorent.value(forKey: "rating") as? Double{
                            ratingR = String(rating)
                            self.viewCosmos.settings.fillMode = .half
                            self.viewCosmos.rating = rating
                        }
                        
                        if let review = detailsRestorent.value(forKey: "review") as? Int{
                            self.reviewsRef.text = "\(String(format: "%.1f", Double(ratingR) as? Double ?? 0.0)) (\(review) Reviews)"
                        }
                        
                        if let is_favorite = detailsRestorent.value(forKey: "is_favorite") as? Int{
                            self.isFav = String(is_favorite)
                            if is_favorite == 0{
                                self.btnFavRef.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                            }else{
                                self.btnFavRef.setImage(#imageLiteral(resourceName: "heart_like_"), for: .normal)
                            }
                        }
                        
                        if let categoryArray = responseJASON["category"].arrayObject as? NSArray{
                            for index in 0..<categoryArray.count{
                                if let categoryItemDict =  categoryArray[index] as? NSDictionary{
                                    
                                    guard let name = categoryItemDict.value(forKey: "name") as? String else{
                                        print ("No name")
                                        return
                                    }
                                    
                                    guard let type = categoryItemDict.value(forKey: "type") as? Int else{
                                        print ("No type")
                                        return
                                    }
                                    
                                    guard let menuCount = categoryItemDict.value(forKey: "menuCount") as? Int else{
                                        print ("No menuCount")
                                        return
                                    }
                                    
                                    guard let id = categoryItemDict.value(forKey: "id") as? Int else{
                                        print ("No id")
                                        return
                                    }
                                    
                                    var isSelected = Bool()
                                    if index == 0{
                                        isSelected = true
                                    }else{
                                        isSelected = false
                                    }
                                    
                                    print(type)
                                    
                                    let categItem = CategoryDataModel(type: String(type), id: String(id), menuCount: String(menuCount), name: String(name), isSelected: isSelected, index: index)
                                    self.categoryDataModelArray.append(categItem)
                                    
                                }
                            }
                            self.collectionViewHeader.reloadData()
                            if self.categoryDataModelArray.count > 0{
                                self.menulisService(catId:self.categoryDataModelArray[0].id, type: self.categoryDataModelArray[0].type, index: 0)
                            }
                            
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
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            
        }
    }
    
       //TODO: Filter service methods
    internal func FilterService(catId:String,type:String,item_type:String,taste:String,eat_type:String,index:Int){
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
            
            let passDict = ["restorent_id":self.id as AnyObject,
                            "category_id":catId,
                            "type":type,
                            "item_type":item_type,
                            "taste":taste,
                            "eat_type":eat_type] as [String:AnyObject]
            print(passDict)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.listmenufilter.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    if self.menuItemDataModelArray.count > 0{
                        self.menuItemDataModelArray.removeAll()
                    }
                    self.macroObj.hideLoader(view: self.view)
                    print(index)
                    self.collectionViewHeader.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: false)
                    
                    if let menuListArray = responseJASON["menuList"].arrayObject as? NSArray{
                        for item in menuListArray{
                            if let menulistDict = item as? NSDictionary{
                                var nameR = String()
                                var idR = Int()
                                var priceR = Int()
                                var discountR = Int()
                                var imgR = "http://3.8.172.240/just_bite/public/storage/menu/thumbnail/1562306432_Paleo%20Instant.jpg"
                                var descriptionR = String()
                                var item_typeR = Int()
                                var quantityR = Int()
                                var customizeDataModelArrayR = [CustomizesDataModel]()
                                
                                
                                if let name = menulistDict.value(forKey: "name") as? String{
                                    nameR = name
                                }
                                if let price = menulistDict.value(forKey: "price") as? Int{
                                    priceR = price
                                }
                                if let id = menulistDict.value(forKey: "id") as? Int{
                                    idR = id
                                }
                                
                                if let img = menulistDict.value(forKey: "img") as? String{
                                    
                                    print(imgR)
                                    
                                    imgR = img.replacingOccurrences(of: " ", with: "%20")
                                    
                                    print(imgR)
                                    
                                    let phrase = img
                                    let charset = CharacterSet(charactersIn: " ")
                                    if let _ = phrase.rangeOfCharacter(from: charset, options: .caseInsensitive) {
                                        imgR = "http://3.8.172.240/just_bite/public/storage/menu/thumbnail/1562306432_Paleo%20Instant.jpg"
                                    }else {
                                        print("no")
                                        imgR = img
                                    }
                                    
                                }
                                
                                if let description = menulistDict.value(forKey: "description") as? String{
                                    descriptionR = description
                                }
                                
                                if let item_type = menulistDict.value(forKey: "item_type") as? Int{
                                    item_typeR = item_type
                                }
                                
                                if let quantity = menulistDict.value(forKey: "quantity") as? Int{
                                    quantityR = quantity
                                }
                                
                                if let customize = menulistDict.value(forKey: "customizes") as? NSArray{
                                    
                                    print(customize)
                                    var itemHeadingRR = String()
                                    var typeRR = Int()
                                    var variationRR = Int()
                                    var addons = [AddOnDataModel]()
                                    
                                    
                                    if customizeDataModelArrayR.count > 0{
                                        customizeDataModelArrayR.removeAll()
                                    }
                                    
                                    for item in customize{
                                        if let customizeDict = item as? NSDictionary{
                                            if let itemHeading = customizeDict.value(forKey: "itemHeading") as? String{
                                                itemHeadingRR = itemHeading
                                            }
                                            
                                            if let type = customizeDict.value(forKey: "type") as? Int{
                                                typeRR = type
                                            }
                                            if let variation = customizeDict.value(forKey: "variation") as? Int{
                                                variationRR = variation
                                            }
                                            
                                            
                                            if addons.count > 0{
                                                addons.removeAll()
                                            }
                                            
                                            if let addonsArr = customizeDict.value(forKey: "addons") as? NSArray{
                                                for item in addonsArr{
                                                    if let addonsDict = item as? NSDictionary{
                                                        var nameAO = String()
                                                        var idAO = Int()
                                                        var priceAO = Int()
                                                        
                                                        
                                                        if let name = addonsDict.value(forKey: "name") as? String{
                                                            nameAO = name
                                                        }
                                                        
                                                        if let id = addonsDict.value(forKey: "id") as? Int{
                                                            idAO = id
                                                        }
                                                        
                                                        if let price = addonsDict.value(forKey: "price") as? Int{
                                                            priceAO = price
                                                        }
                                                        let addOnItem = AddOnDataModel(name: nameAO, id: idAO, price: priceAO, isSelected: false)
                                                        
                                                        addons.append(addOnItem)
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        customizeDataModelArrayR.append(CustomizesDataModel(itemHeading: itemHeadingRR, type: typeRR, variation: variationRR, addons: addons))
                                    }
                                    
                                    
                                    
                                }
                                self.menuItemDataModelArray.append(menuItemDataModel(name: nameR, id: idR, price: priceR, img: imgR, description: descriptionR, item_type: item_typeR, index: index, quantity: quantityR, totalQuantity: Int(), menu_type: Int(), type: Int(), discount: discountR, customizeDataModelArray: customizeDataModelArrayR, addon: String()))
                            }
                        }
                        self.collectionViewHeader.reloadData()
                        
                        if self.menuItemDataModelArray.count > 0{
                            self.macroObj.hideLoaderEmpty(view: self.tblCart)
                            
                            
                            if self.cart_value != 0{
                                self.btnConfirmRef.isHidden = false
                                self.heigntConsBtn.constant = 60
                            }else{
                                self.btnConfirmRef.isHidden = true
                                self.heigntConsBtn.constant = 0
                            }
                            
                            
                            let realm = try! Realm()
                            if let userInfo = realm.objects(OrderItem.self).first{
                                self.btnConfirmRef.isHidden = false
                                self.heigntConsBtn.constant = 60
                            }else{
                                self.btnConfirmRef.isHidden = false
                                self.heigntConsBtn.constant = 60
                            }
                            
                            self.tblCart.reloadData()
                        }else{
                            self.macroObj.showLoaderEmpty(view: self.tblCart)
                            self.macroObj.hideLoaderNet(view: self.tblCart)
                            self.macroObj.hideWentWrong(view: self.tblCart)
                            self.btnConfirmRef.isHidden = true
                            self.heigntConsBtn.constant = 0
                            
                            self.tblCart.reloadData()
                            
                        }
                    }
                    
                   
                }else{
                    self.macroObj.hideLoader(view: self.view)
                    
                    print("abhi k liye hata do")
                    
                    //                    if let message = responseJASON["message"].string{
                    //                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    //                    }
                    
                    
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
    
    //TODO: Filter service methods Old
    internal func filterService(catId:String,type:String,item_type:String,price:String,index:Int){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            let realm = try! Realm()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            
            
//            restorent_id:1
//            category_id:1
//            type:1
//            price:30000
//            item_type:1
            
            let passDict = ["restorent_id":self.id as AnyObject,
                            "category_id":self.categoryDataModelArray[self.index].id,
                            "type":self.categoryDataModelArray[self.index].type,
                            "price":price,
                            "item_type":item_type] as [String:AnyObject]
            
            print(passDict)
            print(header)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.listmenufilter.rawValue, params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    if self.menuItemDataModelArray.count > 0{
                        self.menuItemDataModelArray.removeAll()
                    }
                    self.macroObj.hideLoader(view: self.view)
                    if let menuListArray = responseJASON["menuList"].arrayObject as? NSArray{
                        for item in menuListArray{
                            if let menulistDict = item as? NSDictionary{
                                var nameR = String()
                                var idR = Int()
                                var priceR = Int()
                                var discountR = Int()
                                var imgR = "http://3.8.172.240/just_bite/public/storage/menu/thumbnail/1562306432_Paleo%20Instant.jpg"
                                var descriptionR = String()
                                var item_typeR = Int()
                                var quantityR = Int()
                                var customizeDataModelArrayR = [CustomizesDataModel]()
                                
                                
                                if let name = menulistDict.value(forKey: "name") as? String{
                                    nameR = name
                                }
                                if let price = menulistDict.value(forKey: "price") as? Int{
                                    priceR = price
                                }
                                if let id = menulistDict.value(forKey: "id") as? Int{
                                    idR = id
                                }
                                
                                if let img = menulistDict.value(forKey: "img") as? String{
                                   
                                    print(imgR)
                                    
                                   imgR = img.replacingOccurrences(of: " ", with: "%20")
                                    
                                    print(imgR)
                                    
                                    let phrase = img
                                    let charset = CharacterSet(charactersIn: " ")
                                    if let _ = phrase.rangeOfCharacter(from: charset, options: .caseInsensitive) {
                                        imgR = "http://3.8.172.240/just_bite/public/storage/menu/thumbnail/1562306432_Paleo%20Instant.jpg"
                                    }else {
                                        print("no")
                                        imgR = img
                                    }
                                    
                                }
                                
                                if let description = menulistDict.value(forKey: "description") as? String{
                                    descriptionR = description
                                }
                                
                                if let item_type = menulistDict.value(forKey: "item_type") as? Int{
                                    item_typeR = item_type
                                }
                                
                                if let quantity = menulistDict.value(forKey: "quantity") as? Int{
                                    quantityR = quantity
                                }
                                
                                if let customize = menulistDict.value(forKey: "customizes") as? NSArray{
                                    
                                    print(customize)
                                    var itemHeadingRR = String()
                                    var typeRR = Int()
                                    var variationRR = Int()
                                    var addons = [AddOnDataModel]()
                                    
                                    
                                    if customizeDataModelArrayR.count > 0{
                                        customizeDataModelArrayR.removeAll()
                                    }
                                    
                                    for item in customize{
                                        if let customizeDict = item as? NSDictionary{
                                            if let itemHeading = customizeDict.value(forKey: "itemHeading") as? String{
                                                itemHeadingRR = itemHeading
                                            }
                                            
                                            if let type = customizeDict.value(forKey: "type") as? Int{
                                                typeRR = type
                                            }
                                            if let variation = customizeDict.value(forKey: "variation") as? Int{
                                                variationRR = variation
                                            }
                                            
                                            
                                            if addons.count > 0{
                                                addons.removeAll()
                                            }
                                            
                                            if let addonsArr = customizeDict.value(forKey: "addons") as? NSArray{
                                                for item in addonsArr{
                                                    if let addonsDict = item as? NSDictionary{
                                                        var nameAO = String()
                                                        var idAO = Int()
                                                        var priceAO = Int()
                                                        
                                                        
                                                        if let name = addonsDict.value(forKey: "name") as? String{
                                                            nameAO = name
                                                        }
                                                        
                                                        if let id = addonsDict.value(forKey: "id") as? Int{
                                                            idAO = id
                                                        }
                                                        
                                                        if let price = addonsDict.value(forKey: "price") as? Int{
                                                            priceAO = price
                                                        }
                                                        let addOnItem = AddOnDataModel(name: nameAO, id: idAO, price: priceAO, isSelected: false)
                                                        
                                                        addons.append(addOnItem)
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        customizeDataModelArrayR.append(CustomizesDataModel(itemHeading: itemHeadingRR, type: typeRR, variation: variationRR, addons: addons))
                                    }
                                    
                                    
                                    
                                }
                                self.menuItemDataModelArray.append(menuItemDataModel(name: nameR, id: idR, price: priceR, img: imgR, description: descriptionR, item_type: item_typeR, index: index, quantity: quantityR, totalQuantity: Int(), menu_type: Int(), type: Int(), discount: discountR, customizeDataModelArray: customizeDataModelArrayR, addon: String()))
                            }
                        }
                        self.collectionViewHeader.reloadData()
                        
                        if self.menuItemDataModelArray.count > 0{
                            self.macroObj.hideLoaderEmpty(view: self.tblCart)
                            
                            
                            if self.cart_value != 0{
                                self.btnConfirmRef.isHidden = false
                                self.heigntConsBtn.constant = 60
                            }else{
                                self.btnConfirmRef.isHidden = true
                                self.heigntConsBtn.constant = 0
                            }
                            
                            
                            let realm = try! Realm()
                            if let userInfo = realm.objects(OrderItem.self).first{
                                self.btnConfirmRef.isHidden = false
                                self.heigntConsBtn.constant = 60
                            }else{
                                self.btnConfirmRef.isHidden = false
                                self.heigntConsBtn.constant = 60
                            }
                            
                            self.tblCart.reloadData()
                        }else{
                            self.macroObj.showLoaderEmpty(view: self.tblCart)
                            self.macroObj.hideLoaderNet(view: self.tblCart)
                            self.macroObj.hideWentWrong(view: self.tblCart)
                            self.btnConfirmRef.isHidden = true
                            self.heigntConsBtn.constant = 0
                            
                            self.tblCart.reloadData()
                            
                        }
                    }
                    
                }else{
                    self.macroObj.hideLoader(view: self.view)
                    
                    print("abhi k liye hata do")
                    
//                    if let message = responseJASON["message"].string{
//                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
//                    }
                    
                    
                }
                
            }, failure: { (error) in
                self.macroObj.hideLoader(view: self.view)
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
                self.macroObj.showWentWrong(view: self.tblCart)
                self.macroObj.hideLoaderEmpty(view: self.tblCart)
                self.macroObj.hideLoaderNet(view: self.tblCart)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblCart)
            macroObj.hideLoaderEmpty(view: self.tblCart)
            macroObj.hideWentWrong(view: self.tblCart)
            
        }
    }
    
    
    //TODO: Menu list service
    internal func menulisService(catId:String,type:String,index:Int){
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
            
            
            let passDict = ["restorent_id":self.id as AnyObject,
                            "category_id":catId,
                            "user_id":id,
                            "type":type] as [String:AnyObject]
            
            print(passDict)
            print(header)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.listmenu.rawValue, params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    if self.menuItemDataModelArray.count > 0{
                        self.menuItemDataModelArray.removeAll()
                    }
                    self.macroObj.hideLoader(view: self.view)
                    
                     self.collectionViewHeader.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: false)
                    
                    if let menuListArray = responseJASON["menuList"].arrayObject as? NSArray{
                        for item in menuListArray{
                            if let menulistDict = item as? NSDictionary{
                                var nameR = String()
                                var idR = Int()
                                var priceR = Int()
                                var imgR = "http://3.8.172.240/just_bite/public/storage/menu/thumbnail/1562306432_Paleo%20Instant.jpg"
                                var descriptionR = String()
                                var item_typeR = Int()
                                var quantityR = Int()
                                var discountR = Int()
                                var customizeDataModelArrayR = [CustomizesDataModel]()
                                
                                
                                if let name = menulistDict.value(forKey: "name") as? String{
                                    nameR = name
                                }
                                if let price = menulistDict.value(forKey: "price") as? Int{
                                    priceR = price
                                }
                                if let id = menulistDict.value(forKey: "id") as? Int{
                                    idR = id
                                }
                                
                                if let img = menulistDict.value(forKey: "img") as? String{
                                    print(imgR)
                                    imgR = img.replacingOccurrences(of: " ", with: "%20")
                                    print(imgR)
                                    let phrase = img
                                    let charset = CharacterSet(charactersIn: " ")
                                    if let _ = phrase.rangeOfCharacter(from: charset, options: .caseInsensitive) {
                                       imgR = "http://3.8.172.240/just_bite/public/storage/menu/thumbnail/1562306432_Paleo%20Instant.jpg"
                                    }
                                    else {
                                        print("no")
                                        imgR = img
                                    }
                                    
                                }
                                
                                if let description = menulistDict.value(forKey: "description") as? String{
                                    descriptionR = description
                                }
                                
                                if let item_type = menulistDict.value(forKey: "item_type") as? Int{
                                    item_typeR = item_type
                                }
                                
                                if let quantity = menulistDict.value(forKey: "quantity") as? Int{
                                    quantityR = quantity
                                }
                                
                                if let discount = menulistDict.value(forKey: "discount") as? Int{
                                    discountR = discount
                                }
                                
                                if let customize = menulistDict.value(forKey: "customizes") as? NSArray{
                                    
                                    print(customize)
                                    var itemHeadingRR = String()
                                    var typeRR = Int()
                                    var variationRR = Int()
                                    var addons = [AddOnDataModel]()
                                   
                                    
                                    if customizeDataModelArrayR.count > 0{
                                        customizeDataModelArrayR.removeAll()
                                    }
                                    
                                    for item in customize{
                                        if let customizeDict = item as? NSDictionary{
                                            if let itemHeading = customizeDict.value(forKey: "itemHeading") as? String{
                                                itemHeadingRR = itemHeading
                                            }
                                            
                                            if let type = customizeDict.value(forKey: "type") as? Int{
                                                typeRR = type
                                            }
                                            if let variation = customizeDict.value(forKey: "variation") as? Int{
                                                variationRR = variation
                                            }
                                            
                                            
                                            if addons.count > 0{
                                                addons.removeAll()
                                            }
                                            
                                            if let addonsArr = customizeDict.value(forKey: "addons") as? NSArray{
                                                for item in addonsArr{
                                                    if let addonsDict = item as? NSDictionary{
                                                        var nameAO = String()
                                                        var idAO = Int()
                                                        var priceAO = Int()
                                                       
                                                        
                                                        if let name = addonsDict.value(forKey: "name") as? String{
                                                            nameAO = name
                                                        }
                                                        
                                                        if let id = addonsDict.value(forKey: "id") as? Int{
                                                            idAO = id
                                                        }
                                                        
                                                        if let price = addonsDict.value(forKey: "price") as? Int{
                                                            priceAO = price
                                                        }
                                                        let addOnItem = AddOnDataModel(name: nameAO, id: idAO, price: priceAO, isSelected: false)
                                                        
                                                        addons.append(addOnItem)
                                                    }
                                                }
                                            }

                                        }
                                        
                                        customizeDataModelArrayR.append(CustomizesDataModel(itemHeading: itemHeadingRR, type: typeRR, variation: variationRR, addons: addons))
                                    }
                                    
                                    
                                    
                                }
                                let itemDataModel = menuItemDataModel(name: nameR, id: idR, price: priceR, img: imgR, description: descriptionR, item_type: item_typeR, index: index, quantity: quantityR, totalQuantity: quantityR, menu_type: Int(), type: Int(), discount: discountR, customizeDataModelArray: customizeDataModelArrayR, addon: String())
                                self.menuItemDataModelArray.append(itemDataModel)

                            }
                        }
                        
                        
                        if let userInfo = realm.objects(SignupDataModel.self).first{
                            
                            if userInfo.access_token == ""{
                                
                                let orders = realm.objects(OrderItem.self)
                                
                                if orders.count > 0{
                                    for item in self.menuItemDataModelArray{
                                        var totolQuantity = Int()
                                        for order in orders{
                                            if item.id == order.id && item.addon == order.addOns{
                                                item.quantity = order.quantity
                                            }
                                        }
                                        
                                        if item.customizeDataModelArray.count > 0{
                                            for order in orders{
                                                if item.id == order.id{
                                                    totolQuantity += order.totolQuantity
                                                }
                                            }
                                        }
                                        if item.customizeDataModelArray.count > 0{
                                            item.totalQuantity = totolQuantity
                                        }
                                    }
                                }
                                
                            }else{
                                
                            }
                        }else{
                           
                            let orders = realm.objects(OrderItem.self)
                            
                            if orders.count > 0{
                                for item in self.menuItemDataModelArray{
                                    var totolQuantity = Int()
                                    for order in orders{
                                        if item.id == order.id && item.addon == order.addOns{
                                            item.quantity = order.quantity
                                        }
                                    }
                                    
                                    if item.customizeDataModelArray.count > 0{
                                        for order in orders{
                                            if item.id == order.id{
                                                totolQuantity += order.totolQuantity
                                            }
                                        }
                                    }
                                    if item.customizeDataModelArray.count > 0{
                                        item.totalQuantity = totolQuantity
                                    }
                                }
                            }
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        self.collectionViewHeader.reloadData()
                        
                        if self.menuItemDataModelArray.count > 0{
                            self.macroObj.hideLoaderEmpty(view: self.tblCart)

                            
                            self.tblCart.reloadData()
                        }else{
                            self.macroObj.showLoaderEmpty(view: self.tblCart)
                            self.macroObj.hideLoaderNet(view: self.tblCart)
                            self.macroObj.hideWentWrong(view: self.tblCart)
                            self.btnConfirmRef.isHidden = true
                            self.heigntConsBtn.constant = 0
                            self.tblCart.reloadData()
                            
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
                self.macroObj.showWentWrong(view: self.tblCart)
                self.macroObj.hideLoaderEmpty(view: self.tblCart)
                self.macroObj.hideLoaderNet(view: self.tblCart)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblCart)
            macroObj.hideLoaderEmpty(view: self.tblCart)
            macroObj.hideWentWrong(view: self.tblCart)
            
        }
    }
    
    
    
    //TODO: Add favorite service
    internal func addFavService(token_type:String,access_token:String,view:UIView,id:String,isFav:String){
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
                        self.btnFavRef.setImage(#imageLiteral(resourceName: "heart_like_"), for: .normal)
                        self.isFav = "1"
                        
                    }else{
                        self.btnFavRef.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                        self.macroObj.hideLoaderBrokenHeart(view: view)
                        self.isFav = "0"
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
                
            })
            
        }else{
            if isFav == "0"{
                self.macroObj.hideLoaderHeart(view: view)
            }else{
                self.macroObj.hideLoaderBrokenHeart(view: view)
            }
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    
    
    //TODO: Add to cart
    internal func addToCart(catId:String,type:String,index:Int,qty:Int,price:Double,newOreder:String,menu_id:String,addon:String,status:String){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            var access_token = String()
            var token_type = String()
            let realm = try! Realm()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                
                xLoc = userInfo.xLoc
                access_token = userInfo.access_token
                token_type = userInfo.token_type
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json",
                          "Content-Type":"application/x-www-form-urlencoded",
                          "Authorization":"\(token_type) \(access_token)"]
            
            let passDict = ["restaurant_id":String(self.id),
                            "category_id":String(catId),
                            "type":String(type),
                            "quantity":String(qty),
                            "menu_id":String(menu_id),
                            "price":String(price),
                            "addon":String(addon),
                            "newOrder":newOreder,
                            "status":status] as [String:AnyObject]
            
            print(passDict)
            print(header)
            
            macroObj.showLoader(view: view)
            
            alamoFireObj.postRequestURLUndcoded(MacrosForAll.APINAME.addtocart.rawValue, params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    
                    if self.searchActive{
                        
                        self.filterMenuDataArray[index].quantity = qty
                        
                        if self.filterMenuDataArray.contains(where: {$0.quantity != 0}){
                            self.btnConfirmRef.isHidden = false
                            self.heigntConsBtn.constant = 60
                        }else{
                            self.btnConfirmRef.isHidden = true
                            self.heigntConsBtn.constant = 0
                        }
                        
                    }else{
                        self.menuItemDataModelArray[index].quantity = qty
                        
                        if self.menuItemDataModelArray.contains(where: {$0.quantity != 0}){
                            self.btnConfirmRef.isHidden = false
                            self.heigntConsBtn.constant = 60
                        }else{
                            self.btnConfirmRef.isHidden = true
                            self.heigntConsBtn.constant = 0
                        }
                    }
                    
                    
                  
                    
                    let realm = try! Realm()
                    if let userInfo = realm.objects(OrderItem.self).first{
                        self.btnConfirmRef.isHidden = false
                        self.heigntConsBtn.constant = 60
                    }else{
                        self.btnConfirmRef.isHidden = false
                        self.heigntConsBtn.constant = 60
                    }
                    
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    guard let cell = self.tblCart.cellForRow(at: indexPath) as? CartTableViewCellAndXib else{
                        print("No cell")
                        return
                    }
                    cell.btnQtyRef.setTitle("\(qty)", for: .normal)
                    
                }else{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        
                        if message == "Restaurant change"{
                            
                            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.WantToChangeRest, style: AlertStyle.warning, buttonTitle:ConstantTexts.no, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.yes,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                                if isOtherButton == true {
                                    print("Do nothing")
                                }
                                else
                                {
                                    self.calladdCartMethod(index:self.index, isComing: true, userType: "USER")
                                }
                                
                            }
                            
                            
                        }else{
                            _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                        }
                        
                        
                    }
                    
                }
                
            }, failure: { (error) in
                self.macroObj.hideLoader(view: self.view)
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
                self.macroObj.showWentWrong(view: self.tblCart)
                self.macroObj.hideLoaderEmpty(view: self.tblCart)
                self.macroObj.hideLoaderNet(view: self.tblCart)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblCart)
            macroObj.hideLoaderEmpty(view: self.tblCart)
            macroObj.hideWentWrong(view: self.tblCart)
            
        }
    }
    
    
}


//MARK: - Realm Methods
extension RestaurentDetailsVC{
    //TODO: For auto increament
    internal func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(OrderItem.self).max(ofProperty: "columnId") as Int? ?? 0) + 1
    }
    
    
    //TODO: For delete all records from realm table
    internal func deleteRealm(index:Int,qty:Int,addon:String){
        let orders = realm.objects(OrderItem.self)
        do{
            try realm.write {
                realm.delete(orders)
               
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
        
        
        
        callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: String())
    }
    
    
    //TODO: Update and save new record in realm
    internal func callAddCartLocalyMethod(index:Int,isComing:Bool,qty:Int,addon:String){
        
        if searchActive{
            if self.filterMenuDataArray[index].customizeDataModelArray.count > 0{
                let orders = realm.objects(OrderItem.self)
                var flag = Bool()
                for item in orders{
                    if item.id == filterMenuDataArray[index].id{
                        flag = true
                        do{
                            try realm.write {
                                item.quantity = qty
                                item.totolQuantity = item.quantity
                                item.totalPrice += self.price
                                item.addOns = self.addOn
                                filterMenuDataArray[index].quantity = item.quantity
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    }else{
                        
                    }
                    
                }
                updateCart()
                if flag == false{
                    let orderItem = OrderItem()
                    orderItem.RestaurentName = self.restaurentName
                    orderItem.RestaurentAddress = self.restaurentAddress
                    orderItem.columnId = incrementID()
                    orderItem.name = self.filterMenuDataArray[index].name
                    orderItem.addOns = self.addOn
                    orderItem.id = self.filterMenuDataArray[index].id
                    orderItem.img = self.filterMenuDataArray[index].img
                    orderItem.price = self.price
                    orderItem.totalPrice = self.price
                    orderItem.RestaurentId = self.id
                    orderItem.RestaurentName = self.restaurentName
                    orderItem.RestaurentAddress = self.restaurentAddress
                    orderItem.RestaurentLat = self.restaurentLat
                    orderItem.RestaurentLong = self.restaurentLong
                    orderItem.RestaurentDiscount = self.filterMenuDataArray[index].discount
                    orderItem.itemType = self.filterMenuDataArray[index].item_type
                    
                    orderItem.quantity = qty
                    orderItem.totolQuantity = qty
                    self.filterMenuDataArray[index].quantity = orderItem.quantity
                    
                    orderItem.menuCount = 0
                    orderItem.type = self.categoryDataModelArray[index].id
                    //  orderItem.customizes = [Int]()
                    orderItem.catName = categoryDataModelArray[index].name
                    saveToOrder(item: orderItem)
                }
                
                
                
            }else{
                let orderItem = OrderItem()
                orderItem.columnId = incrementID()
                orderItem.RestaurentName = self.restaurentName
                orderItem.RestaurentAddress = self.restaurentAddress
                orderItem.name = self.filterMenuDataArray[index].name
                orderItem.addOns = ""
                orderItem.id = self.filterMenuDataArray[index].id
                orderItem.img = self.filterMenuDataArray[index].img
                orderItem.price = self.filterMenuDataArray[index].price
                orderItem.totalPrice = self.filterMenuDataArray[index].price
                orderItem.RestaurentId = self.id
                orderItem.RestaurentName = self.restaurentName
                orderItem.RestaurentAddress = self.restaurentAddress
                orderItem.RestaurentLat = self.restaurentLat
                orderItem.RestaurentLong = self.restaurentLong
                orderItem.RestaurentDiscount = self.filterMenuDataArray[index].discount
                orderItem.itemType = self.filterMenuDataArray[index].item_type
                
                orderItem.quantity = qty
                orderItem.totolQuantity = qty
                
                orderItem.menuCount = 0
                orderItem.type = self.categoryDataModelArray[index].id
                //  orderItem.customizes = [Int]()
                orderItem.catName = categoryDataModelArray[index].name
                saveToOrder(item: orderItem)
            }
        }else{
            if self.menuItemDataModelArray[index].customizeDataModelArray.count > 0{
                let orders = realm.objects(OrderItem.self)
                var flag = Bool()
                for item in orders{
                    if item.id == menuItemDataModelArray[index].id{
                        flag = true
                        do{
                            try realm.write {
                                item.quantity = qty
                                item.totolQuantity = item.quantity
                                item.totalPrice += self.price
                                item.addOns = self.addOn
                                menuItemDataModelArray[index].quantity = item.quantity
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    }else{
                        
                    }
                    
                }
                updateCart()
                if flag == false{
                    let orderItem = OrderItem()
                    orderItem.RestaurentName = self.restaurentName
                    orderItem.RestaurentAddress = self.restaurentAddress
                    orderItem.columnId = incrementID()
                    orderItem.name = self.menuItemDataModelArray[index].name
                    orderItem.addOns = self.addOn
                    orderItem.id = self.menuItemDataModelArray[index].id
                    orderItem.img = self.menuItemDataModelArray[index].img
                    orderItem.price = self.price
                    orderItem.totalPrice = self.price
                    orderItem.RestaurentId = self.id
                    orderItem.RestaurentName = self.restaurentName
                    orderItem.RestaurentAddress = self.restaurentAddress
                    orderItem.RestaurentLat = self.restaurentLat
                    orderItem.RestaurentLong = self.restaurentLong
                    orderItem.RestaurentDiscount = self.menuItemDataModelArray[index].discount
                    orderItem.itemType = self.menuItemDataModelArray[index].item_type
                    
                    orderItem.quantity = qty
                    orderItem.totolQuantity = qty
                    self.menuItemDataModelArray[index].quantity = orderItem.quantity
                    
                    orderItem.menuCount = 0
                    orderItem.type = self.categoryDataModelArray[index].id
                    //  orderItem.customizes = [Int]()
                    orderItem.catName = categoryDataModelArray[index].name
                    saveToOrder(item: orderItem)
                }
                
                
                
            }else{
                let orderItem = OrderItem()
                orderItem.columnId = incrementID()
                orderItem.RestaurentName = self.restaurentName
                orderItem.RestaurentAddress = self.restaurentAddress
                orderItem.name = self.menuItemDataModelArray[index].name
                orderItem.addOns = ""
                orderItem.id = self.menuItemDataModelArray[index].id
                orderItem.img = self.menuItemDataModelArray[index].img
                orderItem.price = self.menuItemDataModelArray[index].price
                orderItem.totalPrice = self.menuItemDataModelArray[index].price
                orderItem.RestaurentId = self.id
                orderItem.RestaurentName = self.restaurentName
                orderItem.RestaurentAddress = self.restaurentAddress
                orderItem.RestaurentLat = self.restaurentLat
                orderItem.RestaurentLong = self.restaurentLong
                orderItem.RestaurentDiscount = self.menuItemDataModelArray[index].discount
                orderItem.itemType = self.menuItemDataModelArray[index].item_type
                
                orderItem.quantity = qty
                orderItem.totolQuantity = qty
                
                orderItem.menuCount = 0
                orderItem.type = self.categoryDataModelArray[index].id
                //  orderItem.customizes = [Int]()
                orderItem.catName = categoryDataModelArray[index].name
                saveToOrder(item: orderItem)
            }
        }
        
        
        
        
    }
    
    
    internal func callAddCartLocalyMethodForCustomize(index:Int,isComing:Bool,qty:Int,addon:String){
        if self.menuItemDataModelArray[index].customizeDataModelArray.count > 0{
            let orders = realm.objects(OrderItem.self)
            var flag = Bool()
            var totalQuantity = Int()
            for item in orders{
                if item.id == menuItemDataModelArray[index].id && item.addOns == addon{
                    flag = true
                    do{
                        try realm.write {
                            item.quantity = qty
                            
                            if item.id == menuItemDataModelArray[index].id{
                              totalQuantity += item.quantity
                            }
                            item.totolQuantity = totalQuantity
                            item.totalPrice += self.price
                            item.addOns = self.addOn
                            menuItemDataModelArray[index].quantity = item.quantity
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }else{
                    
                }
                
            }
            updateCart()
            if flag == false{
                let orderItem = OrderItem()
                orderItem.columnId = incrementID()
                orderItem.RestaurentName = self.restaurentName
                orderItem.RestaurentAddress = self.restaurentAddress
                orderItem.name = self.menuItemDataModelArray[index].name
                orderItem.addOns = self.addOn
                orderItem.id = self.menuItemDataModelArray[index].id
                orderItem.img = self.menuItemDataModelArray[index].img
                orderItem.price = self.price
                orderItem.totalPrice = self.price
                orderItem.RestaurentId = self.id
                orderItem.RestaurentName = self.restaurentName
                orderItem.RestaurentAddress = self.restaurentAddress
                orderItem.RestaurentLat = self.restaurentLat
                orderItem.RestaurentLong = self.restaurentLong
                orderItem.RestaurentDiscount = self.menuItemDataModelArray[index].discount
                orderItem.itemType = self.menuItemDataModelArray[index].item_type
                
                orderItem.quantity = qty
                orderItem.totolQuantity = qty
                self.menuItemDataModelArray[index].quantity = orderItem.quantity
                
                orderItem.menuCount = 0
                orderItem.type = self.categoryDataModelArray[index].id
                //  orderItem.customizes = [Int]()
                orderItem.catName = categoryDataModelArray[index].name
                saveToOrder(item: orderItem)
            }
            
            
            
        }else{
            let orderItem = OrderItem()
            orderItem.columnId = incrementID()
            orderItem.RestaurentName = self.restaurentName
            orderItem.RestaurentAddress = self.restaurentAddress
            orderItem.name = self.menuItemDataModelArray[index].name
            orderItem.addOns = ""
            orderItem.id = self.menuItemDataModelArray[index].id
            orderItem.img = self.menuItemDataModelArray[index].img
            orderItem.price = self.menuItemDataModelArray[index].price
            orderItem.totalPrice = self.menuItemDataModelArray[index].price
            orderItem.RestaurentId = self.id
            orderItem.RestaurentName = self.restaurentName
            orderItem.RestaurentAddress = self.restaurentAddress
            orderItem.RestaurentLat = self.restaurentLat
            orderItem.RestaurentLong = self.restaurentLong
            orderItem.RestaurentDiscount = self.menuItemDataModelArray[index].discount
            orderItem.itemType = self.menuItemDataModelArray[index].item_type
            
            orderItem.quantity = qty
            orderItem.totolQuantity = qty
            
            orderItem.menuCount = 0
            orderItem.type = self.categoryDataModelArray[index].id
            //  orderItem.customizes = [Int]()
            orderItem.catName = categoryDataModelArray[index].name
            saveToOrder(item: orderItem)
        }
        
    }

    
    
    //TODO: Save new data to table
    internal func saveToOrder(item: OrderItem){
        do{
            try realm.write{
                realm.add(item)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        updateCart()
    }
    
    //TODO: Update cart with realm
    internal func updateCart(){
        
        if searchActive{
            
            let orders = realm.objects(OrderItem.self)
            for item in self.filterMenuDataArray{
                var totalQuantity = Int()
                for order in orders{
                    if item.id == order.id && item.addon == order.addOns{
                        item.quantity = order.quantity
                    }
                }
                
                for order in orders{
                    
                    if item.customizeDataModelArray.count > 0{
                        if item.id == order.id{
                            totalQuantity += order.quantity
                        }
                    }
                    
                    
                }
                
                if item.customizeDataModelArray.count > 0{
                    item.totalQuantity = totalQuantity
                }
                
            }
            tblCart.reloadData()
        }else{
            
            let orders = realm.objects(OrderItem.self)
            for item in self.menuItemDataModelArray{
                var totalQuantity = Int()
                for order in orders{
                    if item.id == order.id && item.addon == order.addOns{
                        item.quantity = order.quantity
                    }
                }
                
                for order in orders{
                    
                    if item.customizeDataModelArray.count > 0{
                        if item.id == order.id{
                            totalQuantity += order.quantity
                        }
                    }
                    
                    
                }
                
                if item.customizeDataModelArray.count > 0{
                    item.totalQuantity = totalQuantity
                }
                
            }
            tblCart.reloadData()
        }
        
       
    }
    
    
    //TODO: Add and minus quantity in realm
    internal func addMinusToOrders(qty:Int,isComing:String,index:Int,addon:String){
        
        if searchActive{
            if isComing == "ADD"{
                if let restorentInfo = realm.objects(OrderItem.self).first{
                    if String(restorentInfo.RestaurentId) == self.id{
                        let orders = realm.objects(OrderItem.self)
                        var flag = Bool()
                        
                        for item in orders{
                            if item.id == filterMenuDataArray[index].id && item.addOns == filterMenuDataArray[index].addon{
                                flag = true
                                do{
                                    try realm.write {
                                        item.quantity = qty
                                        item.totolQuantity = item.quantity
                                        item.totalPrice += filterMenuDataArray[index].price
                                        
                                    }
                                }catch{
                                    print(error.localizedDescription)
                                }
                            }else{
                                
                            }
                            
                        }
                        if flag == false{
                            callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: addon)
                        }
                        
                        
                        self.updateCart()
                        
                    }else{
                        if let restorentInfo = realm.objects(OrderItem.self).first{
                            
                            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.WantToChangeRest, style: AlertStyle.warning, buttonTitle:ConstantTexts.no, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.yes,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                                if isOtherButton == true {
                                    print("Do nothing")
                                }
                                else
                                {
                                    self.deleteRealm(index: index, qty:qty, addon: String())
                                }
                                
                            }
                        }
                        
                        
                    }
                }else{
                    callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: addon)
                }
            }else{
                if let restorentInfo = realm.objects(OrderItem.self).first{
                    if String(restorentInfo.RestaurentId) == self.id{
                        
                        print(qty)
                        if qty == 0{
                            self.filterMenuDataArray[index].quantity = 0
                            deleteRowAt(index:index)
                            
                        }else{
                            updateMinusAt(index:index,qty:qty)
                        }
                    }else{
                        updateCart()
                        print("do nothing")
                    }
                }else{
                    updateCart()
                    print("do nothing")
                }
                
            }
            
            
            
            
        }else{
            if isComing == "ADD"{
                if let restorentInfo = realm.objects(OrderItem.self).first{
                    if String(restorentInfo.RestaurentId) == self.id{
                        let orders = realm.objects(OrderItem.self)
                        var flag = Bool()
                        
                        for item in orders{
                            if item.id == menuItemDataModelArray[index].id && item.addOns == menuItemDataModelArray[index].addon{
                                flag = true
                                do{
                                    try realm.write {
                                        item.quantity = qty
                                        item.totolQuantity = item.quantity
                                        item.totalPrice += menuItemDataModelArray[index].price
                                        
                                    }
                                }catch{
                                    print(error.localizedDescription)
                                }
                            }else{
                                
                            }
                            
                        }
                        if flag == false{
                            callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: addon)
                        }
                        
                        
                        self.updateCart()
                        
                    }else{
                        if let restorentInfo = realm.objects(OrderItem.self).first{
                            
                            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.WantToChangeRest, style: AlertStyle.warning, buttonTitle:ConstantTexts.no, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.yes,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                                if isOtherButton == true {
                                    print("Do nothing")
                                }
                                else
                                {
                                    self.deleteRealm(index: index, qty:qty, addon: String())
                                }
                                
                            }
                        }
                        
                        
                    }
                }else{
                    callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: addon)
                }
            }else{
                if let restorentInfo = realm.objects(OrderItem.self).first{
                    if String(restorentInfo.RestaurentId) == self.id{
                        
                        print(qty)
                        if qty == 0{
                            self.menuItemDataModelArray[index].quantity = 0
                            deleteRowAt(index:index)
                            
                        }else{
                            updateMinusAt(index:index,qty:qty)
                        }
                    }else{
                        updateCart()
                        print("do nothing")
                    }
                }else{
                    updateCart()
                    print("do nothing")
                }
                
            }
        }
        
        
       
        
        
        
        
    }
    
    //TODO: Add for customize data in realm
    internal func addCustomizeOrederToRealm(qty:Int,isComing:String,index:Int,addon:String,catIndex:Int){
        
        if isComing == "ADD"{
            if let restorentInfo = realm.objects(OrderItem.self).first{
                if String(restorentInfo.RestaurentId) == self.id{
                    let orders = realm.objects(OrderItem.self)
                    var flag = Bool()
                    
                    for item in orders{
                        if item.id == menuItemDataModelArray[index].id && item.addOns == addon{
                            flag = true
                            do{
                                try realm.write {
                                    item.quantity = qty
                                    item.totolQuantity = item.quantity
                                    item.totalPrice += menuItemDataModelArray[index].price
                                    menuItemDataModelArray[index].quantity = item.quantity
                                }
                            }catch{
                                print(error.localizedDescription)
                            }
                        }else{
                            
                        }
                        
                    }
                    if flag == false{
                        callAddCartLocalyMethodForCustomize(index:index,isComing:false, qty: 1, addon: addon)
                    }
                    
                    
                    self.updateCart()
                    
                }else{
                    if let restorentInfo = realm.objects(OrderItem.self).first{
                        
                        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.WantToChangeRest, style: AlertStyle.warning, buttonTitle:ConstantTexts.no, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.yes,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                            if isOtherButton == true {
                                print("Do nothing")
                            }
                            else
                            {
                                self.deleteRealm(index: index, qty:qty, addon: String())
                            }
                            
                        }
                    }
                    
                    
                }
            }else{
                callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: addon)
            }
        }else{
            if let restorentInfo = realm.objects(OrderItem.self).first{
                if String(restorentInfo.RestaurentId) == self.id{
                    
                    print(qty)
                    if qty == 0{
                        self.menuItemDataModelArray[index].quantity = 0
                        deleteRowAt(index:index)
                        
                    }else{
                        updateMinusAt(index:index,qty:qty)
                    }
                }else{
                    updateCart()
                    print("do nothing")
                }
            }else{
                updateCart()
                print("do nothing")
            }
            
        }
        
        
        
        
    }
    
    
    
    //TODO: For delete a record from realm table
    internal func deleteRowAt(index:Int){
        let orders = realm.objects(OrderItem.self)
        for index1 in 0..<orders.count{
            if orders[index1].id == menuItemDataModelArray[index].id{
                do{
                    try realm.write {
                        realm.delete(orders[index1])
                        menuItemDataModelArray[index1].quantity = 0
                       
                    }
                     break
                }catch{
                    print("Error in saving data :- \(error.localizedDescription)")
                     break
                }
            }
        }
        
        updateCart()
    }
    
    
    
    //TODO: update quantity
    internal func updateMinusAt(index:Int,qty:Int){
        let orders = realm.objects(OrderItem.self)
        var flag = Bool()
        for item in orders{
            if item.id == menuItemDataModelArray[index].id && item.addOns == menuItemDataModelArray[index].addon{
                flag = true
                do{
                    try realm.write {
                        item.quantity = qty
                        item.totolQuantity = item.quantity
                        item.totalPrice -= menuItemDataModelArray[index].price
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                
            }
            
        }
        
        updateCart()
    }
    
    //TODO: Load orders from realm
    internal func loadOrders(){
        //    ordars = realm.objects(OrderItem.self)
        
    }
    
}
