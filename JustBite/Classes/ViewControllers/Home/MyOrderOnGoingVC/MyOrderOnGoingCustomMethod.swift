//
//  MyOrderOnGoingCustomMethod.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension MyOrderOngoingVC{
    internal func initialSetup(){
        
        updateUI()
        
        //   tblViewHome.tableHeaderView = header
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        
        ScreeNNameClass.shareScreenInstance.screenName = MyOrderOngoingVC.className
        NotificationCenter.default.addObserver(self,selector:#selector(self.reloadHomeApi(_:)),name:NSNotification.Name(rawValue: "MyOngoingReload"),object: nil)
        
        NotificationCenter.default.addObserver(self,selector:#selector(self.reloadPastApi(_:)),name:NSNotification.Name(rawValue: "MyPastReload"),object: nil)
        
        hideKeyboardWhenTappedAround()
        tblViewHome.backgroundColor = AppColor.whiteColor
//        GlobalCustomMethods.shared.provideCornarRadius(btnRef: viewBtn)
        viewBtn.layer.cornerRadius = 10.0
        viewBtn.clipsToBounds = true
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: viewBtn)
//
        
        
        btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        btnOnGoingRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
        btnOnGoingRef.backgroundColor = AppColor.whiteColor
        btnOnGoingRef.setTitle("Ongoing", for: .normal)
        
        btnUpcoming.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        btnUpcoming.setTitleColor(AppColor.placeHolderColor, for: .normal)
        btnUpcoming.backgroundColor = AppColor.whiteColor
        btnUpcoming.setTitle("Upcoming", for: .normal)
        
        btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        btnPreviousRef.setTitleColor(AppColor.whiteColor, for: .normal)
        btnPreviousRef.backgroundColor = AppColor.stepperColor
        btnPreviousRef.setTitle("Previous", for: .normal)
        
       self.tblViewHome.addSubview(self.refreshControl)
        self.registerNib()
        onGoingOrderService()
        
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        super.transparentNavigation()
        super.hideNavigationBar(false)
        super.setupNavigationBarTitle("My Orders", leftBarButtonsType: [.menu], rightBarButtonsType: [.cart])
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: MyOrderOngoingVC.className)
        
         
    }
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblViewHome.register(nib: InnerTableViewCell.className)
    }
    
    
    
    
    
    internal func onGoingOrderService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            var id = String()
            let realm = try! Realm()
            
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            
            let passDict = ["user_id":id as AnyObject] as [String:AnyObject]
            
            print(passDict)
            print(header)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.ongoingorder.rawValue, params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if (responseJASON["status"].string == "true") || responseJASON["status"].boolValue == true{
                    if self.onGoingModelArray.count > 0{
                        self.onGoingModelArray.removeAll()
                    }
                    self.macroObj.hideLoader(view: self.view)
                    if let menuListArray = responseJASON["ongoing_order"].arrayObject as? NSArray{
                        for topItem in menuListArray{
                            if let topItemDict = topItem as? NSDictionary{
                                var addressR = String()
                                var cancel_statusR = Int()
                                var cancel_timeR = Int()
                                var deliveryStatusR = String()
                                var delivery_perosonR = String()
                                var discountR = Double()
                                var expected_delivery_timeR = String()
                                var noteR = String()
                                var orderDateR = String()
                                var order_idR = Int()
                                var order_numberR = String()
                                var order_place_timeR = String()
                                var payment_typeR = String()
                                var phone_numberR = String()
                                var eat_optionR = Double()
                                var priceR = Double()
                                var restaurant_imageR = String()
                                var restaurant_nameR = String()
                                var latitudeR = String()
                                var longitudeR = String()
                                var totalPriceR = Double()
                                var orderMenuR = [orderMenuDataModel]()
                                
                                if let address = topItemDict.value(forKey: "address") as? String{
                                    addressR = address
                                }
                                
                                if let cancel_status = topItemDict.value(forKey: "cancel_status") as? Int{
                                    cancel_statusR = cancel_status
                                }
                                
                                if let cancel_time = topItemDict.value(forKey: "cancel_time") as? Int{
                                    cancel_timeR = cancel_time
                                }
                                if let deliveryStatus = topItemDict.value(forKey: "deliveryStatus") as? String{
                                    deliveryStatusR = deliveryStatus
                                }
                                
                                if let delivery_peroson = topItemDict.value(forKey: "delivery_peroson") as? String{
                                    delivery_perosonR = delivery_peroson
                                }
                                
                                if let discount = topItemDict.value(forKey: "discountR") as? Double{
                                    discountR = discount
                                }
                                
                                if let expected_delivery_time = topItemDict.value(forKey: "expected_delivery_time") as? Int{
                                    expected_delivery_timeR = String(expected_delivery_time)
                                }
                                
                                if let note = topItemDict.value(forKey: "note") as? String{
                                    noteR = note
                                }
                                if let orderDate = topItemDict.value(forKey: "orderDate") as? String{
                                    orderDateR = orderDate
                                }
                                
                                if let order_id = topItemDict.value(forKey: "order_id") as? Int{
                                    order_idR = order_id
                                }
                                
                                if let order_number = topItemDict.value(forKey: "order_number") as? String{
                                    order_numberR = order_number
                                }
                                
                                if let longitude = topItemDict.value(forKey: "longitude") as? String{
                                    longitudeR = longitude
                                }
                                
                                if let latitude = topItemDict.value(forKey: "latitude") as? String{
                                    latitudeR = latitude
                                }
                                
                                if let order_place_time = topItemDict.value(forKey: "order_place_time") as? String{
                                    order_place_timeR = order_place_time
                                }
                                
                                if let payment_type = topItemDict.value(forKey: "payment_type") as? String{
                                    payment_typeR = payment_type
                                }
                                
                                if let phone_number = topItemDict.value(forKey: "phone_number") as? String{
                                    phone_numberR = phone_number
                                }
                                
                                if let price = topItemDict.value(forKey: "price") as? Double{
                                    priceR = price
                                }
                                
                                if let restaurant_image = topItemDict.value(forKey: "restaurant_image") as? String{
                                    restaurant_imageR = restaurant_image
                                }
                                
                                
                                if let restaurant_name = topItemDict.value(forKey: "restaurant_name") as? String{
                                    restaurant_nameR = restaurant_name
                                }
                                
                                if let eat_option = topItemDict.value(forKey: "eat_option") as? Double{
                                    eat_optionR = eat_option
                                    print(eat_optionR)
                                }
                                
                                if let totalPrice = topItemDict.value(forKey: "totalPrice") as? Double{
                                    totalPriceR = totalPrice
                                }
                                
                                if let orderMenu = topItemDict.value(forKey: "orderMenu") as? NSArray{
                                    
                                    if orderMenuR.count > 0{
                                        orderMenuR.removeAll()
                                    }
                                    
                                    for item in orderMenu{
                                        if let itemDict = item as? NSDictionary{
                                            var imageRR = String()
                                            var item_typeRR = Int()
                                            var nameRR = String()
                                            var priceRR = Double()
                                            var quantityRR = Int()
                                            
                                            if let image = itemDict.value(forKey: "image") as? String{
                                                imageRR = image
                                            }
                                            
                                            if let item_type = itemDict.value(forKey: "item_type") as? Int{
                                                item_typeRR = item_type
                                            }
                                            
                                            if let name = itemDict.value(forKey: "name") as? String{
                                                nameRR = name
                                            }
                                            if let price = itemDict.value(forKey: "price") as? Double{
                                                priceRR = price
                                            }
                                            
                                            if let quantity = itemDict.value(forKey: "quantity") as? Int{
                                                quantityRR = quantity
                                            }
                                            
                                            let orderMenuDataModelItem = orderMenuDataModel(image: imageRR, item_type: item_typeRR, name: nameRR, price: priceRR, quantity: quantityRR)
                                            orderMenuR.append(orderMenuDataModelItem)
                                            
                                        }
                                    }
                                    
                                }
                                let onGoingDataModelItem = OnGoingDataModel(address: addressR, cancel_status: cancel_statusR, cancel_time: cancel_timeR, deliveryStatus: deliveryStatusR, delivery_peroson: delivery_perosonR, discount: discountR, expected_delivery_time: expected_delivery_timeR, note: noteR, orderDate: orderDateR, order_id: order_idR, order_number: order_numberR, order_place_time: order_place_timeR, payment_type: payment_typeR, phone_number: phone_numberR, price: priceR, restaurant_image: restaurant_imageR, restaurant_name: restaurant_nameR, totalPrice: totalPriceR, isSelected: false, orderMenu: orderMenuR, delivered_time: String(), restaurent_id: Int(), eat_option: eat_optionR, vist_date: "", vist_time: "", pickup_date: "", pickup_time: "", no_of_people: 0.0, latitude: latitudeR, longitude: longitudeR)
                                self.onGoingModelArray.append(onGoingDataModelItem)

                            }
                        }
                    }
                    
                    
                    
                    print(self.onGoingModelArray.count)
                    
                    if self.onGoingModelArray.count > 0{
                        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
                        self.macroObj.hideWentWrong(view: self.tblViewHome)
                        self.tblViewHome.reloadData()
                        self.tblViewHome.dataSource = self
                        self.tblViewHome.delegate = self
                    }else{
                        self.tblViewHome.reloadData()
                        self.macroObj.showLoaderEmpty(view: self.tblViewHome)
                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
                        self.macroObj.hideWentWrong(view: self.tblViewHome)
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
                self.macroObj.showWentWrong(view: self.tblViewHome)
                self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                self.macroObj.hideLoaderNet(view: self.tblViewHome)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblViewHome)
            macroObj.hideLoaderEmpty(view: self.tblViewHome)
            macroObj.hideWentWrong(view: self.tblViewHome)
            
        }
    }
    
    internal func upGoingOrderService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            var id = String()
            let realm = try! Realm()
            
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            
            let passDict = ["user_id":id as AnyObject] as [String:AnyObject]
            
            print(passDict)
            print(header)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.upgoingorder.rawValue, params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if (responseJASON["status"].string == "true") || responseJASON["status"].boolValue == true{
                    if self.upComingModelArray.count > 0{
                        self.upComingModelArray.removeAll()
                    }
                    self.macroObj.hideLoader(view: self.view)
                    if let menuListArray = responseJASON["upcoming_order"].arrayObject as? NSArray{
                        for topItem in menuListArray{
                            if let topItemDict = topItem as? NSDictionary{
                                var addressR = String()
                                var cancel_statusR = Int()
                                var cancel_timeR = Int()
                                var deliveryStatusR = String()
                                var delivery_perosonR = String()
                                var discountR = Double()
                                var expected_delivery_timeR = String()
                                var noteR = String()
                                var orderDateR = String()
                                var order_idR = Int()
                                var order_numberR = String()
                                var order_place_timeR = String()
                                var payment_typeR = String()
                                var phone_numberR = String()
                                var eat_optionR = Double()
                                var priceR = Double()
                                var restaurant_imageR = String()
                                var restaurant_nameR = String()
                                var totalPriceR = Double()
                                 var vist_dateR = String()
                                 var vist_timeR = String()
                                 var pickup_dateR = String()
                                 var pickup_timeR = String()
                                 var longitudeR = String()
                                 var latitudeR = String()
                                 var no_of_peopleR = Double()
                                var orderMenuR = [orderMenuDataModel]()
                                
                                if let address = topItemDict.value(forKey: "address") as? String{
                                    addressR = address
                                }
                                
                                if let vist_date = topItemDict.value(forKey: "vist_date") as? String{
                                    vist_dateR = vist_date
                                }
                                
                                if let vist_time = topItemDict.value(forKey: "vist_time") as? String{
                                    vist_timeR = vist_time
                                }
                                
                                if let pickup_date = topItemDict.value(forKey: "pickup_date") as? String{
                                    pickup_dateR = pickup_date
                                }
                                
                                if let pickup_time = topItemDict.value(forKey: "pickup_time") as? String{
                                    pickup_timeR = pickup_time
                                }
                                
                                if let no_of_people = topItemDict.value(forKey: "no_of_people") as? Double{
                                    no_of_peopleR = no_of_people
                                }
                                
                                if let cancel_status = topItemDict.value(forKey: "cancel_status") as? Int{
                                    cancel_statusR = cancel_status
                                }
                                
                                if let cancel_time = topItemDict.value(forKey: "cancel_time") as? Int{
                                    cancel_timeR = cancel_time
                                }
                                if let deliveryStatus = topItemDict.value(forKey: "deliveryStatus") as? String{
                                    deliveryStatusR = deliveryStatus
                                }
                                
                                if let delivery_peroson = topItemDict.value(forKey: "delivery_peroson") as? String{
                                    delivery_perosonR = delivery_peroson
                                }
                                
                                if let discount = topItemDict.value(forKey: "discountR") as? Double{
                                    discountR = discount
                                }
                                
                                if let expected_delivery_time = topItemDict.value(forKey: "expected_delivery_time") as? Int{
                                    expected_delivery_timeR = String(expected_delivery_time)
                                }
                                
                                if let note = topItemDict.value(forKey: "note") as? String{
                                    noteR = note
                                }
                                if let orderDate = topItemDict.value(forKey: "orderDate") as? String{
                                    orderDateR = orderDate
                                }
                                
                                if let order_id = topItemDict.value(forKey: "order_id") as? Int{
                                    order_idR = order_id
                                }
                                
                                if let order_number = topItemDict.value(forKey: "order_number") as? String{
                                    order_numberR = order_number
                                }
                                if let longitude = topItemDict.value(forKey: "longitude") as? String{
                                    longitudeR = longitude
                                }
                                
                                if let latitude = topItemDict.value(forKey: "latitude") as? String{
                                    latitudeR = latitude
                                }
                                
                                if let order_place_time = topItemDict.value(forKey: "order_place_time") as? String{
                                    order_place_timeR = order_place_time
                                }
                                
                                if let payment_type = topItemDict.value(forKey: "payment_type") as? String{
                                    payment_typeR = payment_type
                                }
                                
                                if let phone_number = topItemDict.value(forKey: "phone_number") as? String{
                                    phone_numberR = phone_number
                                }
                                
                                if let price = topItemDict.value(forKey: "price") as? Double{
                                    priceR = price
                                }
                                
                                if let restaurant_image = topItemDict.value(forKey: "restaurant_image") as? String{
                                    restaurant_imageR = restaurant_image
                                }
                                
                                
                                if let restaurant_name = topItemDict.value(forKey: "restaurant_name") as? String{
                                    restaurant_nameR = restaurant_name
                                }
                                
                                if let eat_option = topItemDict.value(forKey: "eat_option") as? Double{
                                    eat_optionR = eat_option
                                    print(eat_optionR)
                                }
                                
                                if let totalPrice = topItemDict.value(forKey: "totalPrice") as? Double{
                                    totalPriceR = totalPrice
                                }
                                
                                if let orderMenu = topItemDict.value(forKey: "orderMenu") as? NSArray{
                                    
                                    if orderMenuR.count > 0{
                                        orderMenuR.removeAll()
                                    }
                                    
                                    for item in orderMenu{
                                        if let itemDict = item as? NSDictionary{
                                            var imageRR = String()
                                            var item_typeRR = Int()
                                            var nameRR = String()
                                            var priceRR = Double()
                                            var quantityRR = Int()
                                            
                                            if let image = itemDict.value(forKey: "image") as? String{
                                                imageRR = image
                                            }
                                            
                                            if let item_type = itemDict.value(forKey: "item_type") as? Int{
                                                item_typeRR = item_type
                                            }
                                            
                                            if let name = itemDict.value(forKey: "name") as? String{
                                                nameRR = name
                                            }
                                            if let price = itemDict.value(forKey: "price") as? Double{
                                                priceRR = price
                                            }
                                            
                                            if let quantity = itemDict.value(forKey: "quantity") as? Int{
                                                quantityRR = quantity
                                            }
                                            
                                            let orderMenuDataModelItem = orderMenuDataModel(image: imageRR, item_type: item_typeRR, name: nameRR, price: priceRR, quantity: quantityRR)
                                            orderMenuR.append(orderMenuDataModelItem)
                                            
                                        }
                                    }
                                    
                                }
                                let upGoingDataModelItem = OnGoingDataModel(address: addressR, cancel_status: cancel_statusR, cancel_time: cancel_timeR, deliveryStatus: deliveryStatusR, delivery_peroson: delivery_perosonR, discount: discountR, expected_delivery_time: expected_delivery_timeR, note: noteR, orderDate: orderDateR, order_id: order_idR, order_number: order_numberR, order_place_time: order_place_timeR, payment_type: payment_typeR, phone_number: phone_numberR, price: priceR, restaurant_image: restaurant_imageR, restaurant_name: restaurant_nameR, totalPrice: totalPriceR, isSelected: false, orderMenu: orderMenuR, delivered_time: String(), restaurent_id: Int(), eat_option: eat_optionR, vist_date: vist_dateR, vist_time:vist_timeR, pickup_date: pickup_dateR, pickup_time: pickup_timeR, no_of_people: no_of_peopleR, latitude: latitudeR, longitude: longitudeR)
                                self.upComingModelArray.append(upGoingDataModelItem)
                                
                            }
                        }
                    }
                    
                    
                    
                    print(self.upComingModelArray.count)
                    
                    if self.upComingModelArray.count > 0{
                        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
                        self.macroObj.hideWentWrong(view: self.tblViewHome)
                        self.tblViewHome.reloadData()
                        self.tblViewHome.dataSource = self
                        self.tblViewHome.delegate = self
                    }else{
                        self.tblViewHome.reloadData()
                        self.macroObj.showLoaderEmpty(view: self.tblViewHome)
                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
                        self.macroObj.hideWentWrong(view: self.tblViewHome)
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
                self.macroObj.showWentWrong(view: self.tblViewHome)
                self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                self.macroObj.hideLoaderNet(view: self.tblViewHome)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblViewHome)
            macroObj.hideLoaderEmpty(view: self.tblViewHome)
            macroObj.hideWentWrong(view: self.tblViewHome)
            
        }
    }
    
    
    internal func previousOrderService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            var id = String()
            let realm = try! Realm()
            
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            
            let passDict = ["user_id":id as AnyObject] as [String:AnyObject]
            
            print(passDict)
            print(header)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.previous_order.rawValue, params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if (responseJASON["status"].string == "true") || responseJASON["status"].boolValue == true{
                    if self.previousModelArray.count > 0{
                        self.previousModelArray.removeAll()
                    }
                    self.macroObj.hideLoader(view: self.view)
                    if let menuListArray = responseJASON["previous_order"].arrayObject as? NSArray{
                        for topItem in menuListArray{
                            if let topItemDict = topItem as? NSDictionary{
                                var addressR = String()
                                var cancel_statusR = Int()
                                var cancel_timeR = Int()
                                var deliveryStatusR = String()
                                var delivery_perosonR = String()
                                var discountR = Double()
                                var expected_delivery_timeR = String()
                                var noteR = String()
                                var orderDateR = String()
                                var order_idR = Int()
                                var order_numberR = String()
                                var order_place_timeR = String()
                                var payment_typeR = String()
                                var phone_numberR = String()
                                var priceR = Double()
                                var restaurant_imageR = String()
                                var restaurant_nameR = String()
                                var totalPriceR = Double()
                                var orderMenuR = [orderMenuDataModel]()
                                var delivered_timeRR = String()
                                var restaurant_idRR = Int()
                                var eat_optionR = Double()
                                var longitudeR = String()
                                var latitudeR = String()
                                
                                if let longitude = topItemDict.value(forKey: "longitude") as? String{
                                    longitudeR = longitude
                                }
                                
                                if let latitude = topItemDict.value(forKey: "latitude") as? String{
                                    latitudeR = latitude
                                }
                                
                                if let address = topItemDict.value(forKey: "address") as? String{
                                    addressR = address
                                }
                                
                                if let cancel_status = topItemDict.value(forKey: "cancel_status") as? Int{
                                    cancel_statusR = cancel_status
                                }
                                
                                if let cancel_time = topItemDict.value(forKey: "cancel_time") as? Int{
                                    cancel_timeR = cancel_time
                                }
                                if let deliveryStatus = topItemDict.value(forKey: "deliveryStatus") as? String{
                                    deliveryStatusR = deliveryStatus
                                }
                                
                                if let delivery_peroson = topItemDict.value(forKey: "delivery_peroson") as? String{
                                    delivery_perosonR = delivery_peroson
                                }
                                
                                if let discount = topItemDict.value(forKey: "discountR") as? Double{
                                    discountR = discount
                                }
                                
                                if let expected_delivery_time = topItemDict.value(forKey: "expected_delivery_time") as? String{
                                    expected_delivery_timeR = expected_delivery_time
                                }
                                
                                if let note = topItemDict.value(forKey: "note") as? String{
                                    noteR = note
                                }
                                if let orderDate = topItemDict.value(forKey: "orderDate") as? String{
                                    orderDateR = orderDate
                                }
                                
                                if let order_id = topItemDict.value(forKey: "order_id") as? Int{
                                    order_idR = order_id
                                }
                                
                                if let order_number = topItemDict.value(forKey: "order_number") as? String{
                                    order_numberR = order_number
                                }
                                
                                if let order_place_time = topItemDict.value(forKey: "order_place_time") as? String{
                                    order_place_timeR = order_place_time
                                }
                                
                                if let payment_type = topItemDict.value(forKey: "payment_type") as? String{
                                    payment_typeR = payment_type
                                }
                                
                                if let phone_number = topItemDict.value(forKey: "phone_number") as? String{
                                    phone_numberR = phone_number
                                }
                                
                                if let price = topItemDict.value(forKey: "price") as? Double{
                                    priceR = price
                                }
                                
                                if let restaurant_image = topItemDict.value(forKey: "restaurant_image") as? String{
                                    restaurant_imageR = restaurant_image
                                }
                                
                                
                                if let restaurant_name = topItemDict.value(forKey: "restaurant_name") as? String{
                                    restaurant_nameR = restaurant_name
                                }
                                
                                if let eat_option = topItemDict.value(forKey: "eat_option") as? Double{
                                    eat_optionR = eat_option
                                }
                                
                                if let totalPrice = topItemDict.value(forKey: "totalPrice") as? Double{
                                    totalPriceR = totalPrice
                                }
                                
                                if let orderMenu = topItemDict.value(forKey: "orderMenu") as? NSArray{
                                    
                                    if orderMenuR.count > 0{
                                        orderMenuR.removeAll()
                                    }
                                    
                                    for item in orderMenu{
                                        if let itemDict = item as? NSDictionary{
                                            var imageRR = String()
                                            var item_typeRR = Int()
                                            var nameRR = String()
                                            var priceRR = Double()
                                            var quantityRR = Int()
                                           
                                            if let image = itemDict.value(forKey: "image") as? String{
                                                imageRR = image
                                            }
                                            
                                            if let item_type = itemDict.value(forKey: "item_type") as? Int{
                                                item_typeRR = item_type
                                            }
                                            
                                            if let delivered_time = itemDict.value(forKey: "order_place_time") as? String{
                                                delivered_timeRR = delivered_time
                                            }
                                            
                                            if let name = itemDict.value(forKey: "name") as? String{
                                                nameRR = name
                                            }
                                            
                                            if let price = itemDict.value(forKey: "price") as? Double{
                                                priceRR = price
                                            }
                                            
                                            if let quantity = itemDict.value(forKey: "quantity") as? Int{
                                                quantityRR = quantity
                                            }
                                            
                                            if let restaurant_id = itemDict.value(forKey: "restaurant_id") as? Int{
                                                restaurant_idRR = restaurant_id
                                            }
                                            
                                            let orderMenuDataModelItem = orderMenuDataModel(image: imageRR, item_type: item_typeRR, name: nameRR, price: priceRR, quantity: quantityRR)
                                            orderMenuR.append(orderMenuDataModelItem)
                                            
                                        }
                                    }
                                    
                                }
                                let onGoingDataModelItem = OnGoingDataModel(address: addressR, cancel_status: cancel_statusR, cancel_time: cancel_timeR, deliveryStatus: deliveryStatusR, delivery_peroson: delivery_perosonR, discount: discountR, expected_delivery_time: expected_delivery_timeR, note: noteR, orderDate: orderDateR, order_id: order_idR, order_number: order_numberR, order_place_time: order_place_timeR, payment_type: payment_typeR, phone_number: phone_numberR, price: priceR, restaurant_image: restaurant_imageR, restaurant_name: restaurant_nameR, totalPrice: totalPriceR, isSelected: false, orderMenu: orderMenuR, delivered_time: delivered_timeRR, restaurent_id: restaurant_idRR, eat_option: eat_optionR, vist_date: "", vist_time: "", pickup_date: "", pickup_time: "", no_of_people: 0.0, latitude: latitudeR, longitude: longitudeR)
                                self.previousModelArray.append(onGoingDataModelItem)
                                
                            }
                        }
                    }
                    
                    
                    print(self.previousModelArray.count)
                    
                    if self.previousModelArray.count > 0{
                        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
                        self.macroObj.hideWentWrong(view: self.tblViewHome)
                        self.tblViewHome.reloadData()
                        self.tblViewHome.dataSource = self
                        self.tblViewHome.delegate = self
                    }else{
                        self.tblViewHome.reloadData()
                        self.macroObj.showLoaderEmpty(view: self.tblViewHome)
                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
                        self.macroObj.hideWentWrong(view: self.tblViewHome)
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
                self.macroObj.showWentWrong(view: self.tblViewHome)
                self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                self.macroObj.hideLoaderNet(view: self.tblViewHome)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblViewHome)
            macroObj.hideLoaderEmpty(view: self.tblViewHome)
            macroObj.hideWentWrong(view: self.tblViewHome)
            
        }
    }
    
    
    
    
    internal func cancelOrderService(order_id:String,index:Int){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            var id = String()
            let realm = try! Realm()
            
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            
            let passDict = ["order_number":order_id as AnyObject] as [String:AnyObject]
            
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.cancel_order.rawValue, params: passDict, headers: nil, success: { (responseJASON) in
                print(responseJASON)
                if (responseJASON["status"].string == "true") || responseJASON["status"].boolValue == true{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        self.onGoingModelArray.remove(at: index)
                        self.tblViewHome.reloadData()
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
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
                self.macroObj.showWentWrong(view: self.tblViewHome)
                self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                self.macroObj.hideLoaderNet(view: self.tblViewHome)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblViewHome)
            macroObj.hideLoaderEmpty(view: self.tblViewHome)
            macroObj.hideWentWrong(view: self.tblViewHome)
            
        }
    }
    
    
    
    internal func reOrderService(order_id:String){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            var id = String()
            let realm = try! Realm()
            
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json"]
            
            
            let passDict = ["order_id":order_id,
                            "user_id":id as AnyObject] as [String:AnyObject]
            
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.reorder.rawValue, params: passDict, headers: header, success: { (responseJASON) in
                print(responseJASON)
                if (responseJASON["status"].string == "true") || responseJASON["status"].boolValue == true{
                    ConstantTexts.screenName = "Reorder"
                    self.macroObj.hideLoader(view: self.view)
                    super.cartTapped()
//                    if let message = responseJASON["message"].string{
//                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
//                    }
                    
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
                self.macroObj.showWentWrong(view: self.tblViewHome)
                self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
                self.macroObj.hideLoaderNet(view: self.tblViewHome)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblViewHome)
            macroObj.hideLoaderEmpty(view: self.tblViewHome)
            macroObj.hideWentWrong(view: self.tblViewHome)
            
        }
    }
    
    
}

