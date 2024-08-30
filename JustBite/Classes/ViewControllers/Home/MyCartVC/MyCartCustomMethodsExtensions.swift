//
//  MyCartCustomMethodsExtensions.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields
import RealmSwift
import GoogleMaps
import GooglePlaces




extension MyCartVC:backToCart{
    
    func sendDataBack(index: Int, price: Double, addon: String, isNewOrder: String) {
        
        var qty = menuItemDataModelArray[index].quantity
        qty += 1
       
        print(addon)
        addToCart(catId:String(menuItemDataModelArray[index].id),type:String(menuItemDataModelArray[index].type),index:index,qty:qty,price:price,newOreder:isNewOrder,menu_id:String(menuItemDataModelArray[index].id),addon:addon, status: "plus")
        
    }
    
    
     
    
    func finishPassing(status: String, price: String) {
        //print(string)
        //        self.filterService(catId:categoryDataModelArray[index].id,type:categoryDataModelArray[index].type, item_type: status, price: price,index:index)
    }
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    func addDataToRealm(qty:Int,isComing:String,index:Int,addon:String){

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
                        callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: addon, action: "ADD")
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
                callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: addon, action: "ADD")
            }
        }
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
        
        
        
        callAddCartLocalyMethod(index:index,isComing:false, qty: qty, addon: String(), action: "ADD")
    }
    
    internal func updateCart(){
        if self.menuItemDataModelArray.count > 0{
            self.menuItemDataModelArray.removeAll()
        }
        
        var tPrice = Int()
        var tPaidPrice = Int()
        var tDiscount = Int()
        
        let orders = realm.objects(OrderItem.self)
        for order in 0..<orders.count{
            
            tPrice += orders[order].totalPrice
            tDiscount += orders[order].RestaurentDiscount
            
            restaurentName = orders[order].RestaurentName
            restaurentAddress = orders[order].RestaurentAddress
            
            self.menuItemDataModelArray.append(menuItemDataModel(name: orders[order].name, id: Int(orders[order].RestaurentId) ?? 0, price: orders[order].price, img: orders[order].img, description: orders[order].description, item_type: orders[order].itemType, index: order, quantity: orders[order].quantity, totalQuantity: orders[order].totolQuantity, menu_type: orders[order].menuCount, type: Int(orders[order].type) ?? 0, discount: orders[order].RestaurentDiscount, customizeDataModelArray: [CustomizesDataModel](), addon: orders[order].addOns))
            
            self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: orders[order].RestaurentName, subTitle: orders[order].RestaurentAddress, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
            
        }
        
        
         //Commented by Sonika
        
      /*  if let userInfo = realm.objects(SignupDataModel.self).first{
            if userInfo.id == ""{
                price = String(tPrice - tDiscount)
                self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                
                self.footer.lblPaidValue.text = "AED \(price)"
                
                self.footer.lblDiscountValue.text = "AED \(tDiscount)"
            }
        }else{
            price = String(tPrice - tDiscount)
            self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
            
            self.footer.lblPaidValue.text = "AED \(price)"
            
            self.footer.lblDiscountValue.text = "AED \(tDiscount)"
        } */
        
        
        
       
        
        
        if self.menuItemDataModelArray.count > 0{
            self.macroObj.hideLoaderEmpty(view: self.tblView)
            self.macroObj.hideWentWrong(view: self.tblView)
            self.macroObj.hideLoaderNet(view: self.tblView)
            self.tblView.tableFooterView = self.footer
            self.tblView.tableHeaderView = self.Header
            self.btnSubmit.isHidden = false
            self.lblEmptyField.isHidden = true
            self.tblView.reloadData()
        }else{
            self.menuItemDataModelArray.removeAll()
            self.tblView.tableFooterView = UIView()
            self.tblView.tableHeaderView = UIView()
            self.btnSubmit.isHidden = true
            self.macroObj.showLoaderEmpty(view: self.tblView)
            self.macroObj.hideLoaderNet(view: self.tblView)
            self.macroObj.hideWentWrong(view: self.tblView)
            self.lblEmptyField.isHidden = false
            self.tblView.reloadData()
            
        }
       
        
        
    }
    
    //TODO: Update and save new record in realm
    internal func callAddCartLocalyMethod(index:Int,isComing:Bool,qty:Int,addon:String,action:String){
        
        if action == "ADD"{
            let orders = realm.objects(OrderItem.self)
            do{
                try realm.write {
                    orders[index].quantity = qty + 1
                    orders[index].totolQuantity = orders[index].quantity
                    orders[index].totalPrice += orders[index].price
                }
            }catch{
                print(error.localizedDescription)
            }
        }else{
           
                    if qty == 0{
                        self.menuItemDataModelArray[index].quantity = 0
                        deleteRowAt(index:index)
                        
                    }else{
                        updateMinusAt(index:index,qty:qty)
                    }
            
        }
       
        updateCart()

    }
    
    
    //TODO: update quantity
    internal func updateMinusAt(index:Int,qty:Int){
        let orders = realm.objects(OrderItem.self)
                do{
                    try realm.write {
                        orders[index].quantity = qty
                        orders[index].totolQuantity = orders[index].quantity
                        orders[index].totalPrice -= orders[index].price
                    }
                }catch{
                    print(error.localizedDescription)
                }
           
            
        
        
        updateCart()
    }
    
    
    internal func deleteRowAt(index:Int){
        let orders = realm.objects(OrderItem.self)
                do{
                    try realm.write {
                        realm.delete(orders[index])
                    }
                   
                }catch{
                    print("Error in saving data :- \(error.localizedDescription)")
                   
                }
            
     
        
        updateCart()
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
    
    //TODO: For auto increament
    internal func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(OrderItem.self).max(ofProperty: "columnId") as Int? ?? 0) + 1
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        registerNib()
        hideKeyboardWhenTappedAround()
        
        
     
        
        
        ScreeNNameClass.shareScreenInstance.screenName = MyCartVC.className

        lblEmptyField.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblEmptyField.textColor = AppColor.textColor
        lblEmptyField.text = "Your Cart is Empty.\nAdd something from the menu."
        lblEmptyField.isHidden = false
        
       // viewHeader.backgroundColor = AppColor.themeColor
        self.tblView.addSubview(self.refreshControl)
        self.lblHeader.textColor = AppColor.whiteColor
        self.lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        self.lblHeader.text = "My Cart"
        
        
        self.btnSubmit.backgroundColor = AppColor.stepperColor
        self.btnSubmit.setTitle("Confirm", for: .normal)
        self.btnSubmit.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        
        
        if openType == -1{
            footer.btnLocRef.isHidden = true
            footer.lblAddress.isHidden = true
            footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.lblAddress.textColor = AppColor.textColor
            footer.lblAddress.text = "Total amount to be paid"
            
            footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
            footer.couponCode.textColor = AppColor.textColor
            footer.couponCode.text = "APPLY COUPON"
            
            footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
            
            footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
            footer.lblEatOption.textColor = AppColor.textColor
            footer.lblEatOption.text = "Select Eat Option:"
            
            footer.eatTypeLbl.isHidden = true
            footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.eatTypeLbl.textColor = AppColor.textColor
            footer.eatTypeLbl.text = ""
        }else if openType == 0{
            footer.btnLocRef.isHidden = false
            footer.lblAddress.isHidden = false
            footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.lblAddress.textColor = AppColor.textColor
            footer.lblAddress.text = ""
            
            footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
            footer.couponCode.textColor = AppColor.textColor
            footer.couponCode.text = "COUPON1234"
            
            footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
            
            footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
            footer.lblEatOption.textColor = AppColor.textColor
            footer.lblEatOption.text = "Eat Option:"
            
            footer.eatTypeLbl.isHidden = true
            footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.eatTypeLbl.textColor = AppColor.textColor
            footer.eatTypeLbl.text = "Home Deleivery"
        }else if openType == 1{
            footer.btnLocRef.isHidden = false
            footer.lblAddress.isHidden = false
            footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.lblAddress.textColor = AppColor.textColor
            footer.lblAddress.text = ""
            
            footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
            footer.couponCode.textColor = AppColor.textColor
            footer.couponCode.text = "COUPON1234"
            
            footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
            
            footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
            footer.lblEatOption.textColor = AppColor.textColor
            footer.lblEatOption.text = " Eat Option:"
            
            footer.eatTypeLbl.isHidden = true
            footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.eatTypeLbl.textColor = AppColor.textColor
            footer.eatTypeLbl.text = "Pick Up"
        }else{
            footer.btnLocRef.isHidden = false
            footer.lblAddress.isHidden = false
            footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.lblAddress.textColor = AppColor.textColor
            footer.lblAddress.text = ""
            
            footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
            footer.couponCode.textColor = AppColor.textColor
            footer.couponCode.text = "COUPON1234"
            
            footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
            
            footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
            footer.lblEatOption.textColor = AppColor.textColor
            footer.lblEatOption.text = " Eat Option:"
            
            footer.eatTypeLbl.isHidden = true
            footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            footer.eatTypeLbl.textColor = AppColor.textColor
            footer.eatTypeLbl.text = "Eat At Resturant"
        }
        
        
         //Commented by Sonika
        
     /*   footer.lblTotalPriceHeading.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        footer.lblTotalPriceHeading.textColor = AppColor.placeHolderColor
        footer.lblTotalPriceHeading.text = "Total Price"
        
        footer.lblDiscountHeading.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        footer.lblDiscountHeading.textColor = AppColor.placeHolderColor
        footer.lblDiscountHeading.text = "Discount"
        
        footer.lblPaidAmount.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        footer.lblPaidAmount.textColor = AppColor.textColor
        footer.lblPaidAmount.text = "Total amount to be paid"
        
        footer.lblTotalAmountValue.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        footer.lblTotalAmountValue.textColor = AppColor.placeHolderColor
        
        
        footer.lblDiscountValue.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        footer.lblDiscountValue.textColor = AppColor.placeHolderColor
        
        
        footer.lblPaidValue.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        footer.lblPaidValue.textColor = AppColor.textColor
        
        
        footer.txtView.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 14)
        footer.txtView.textColor = AppColor.placeHolderColor
        footer.txtView.text = "Add extra note..."
        footer.txtView.delegate = self
        
        
        
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: footer.viewText)
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: footer.viewText)
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: footer.viewText, radius: 10)
        
        footer.viewText.backgroundColor = AppColor.whiteColor
        
        footer.textFieldFloating?.delegate = MyCartFooterView.self as? UITextFieldDelegate
        footer.textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: footer.textFieldFloating)
        footer.textFieldControllerFloating?.floatingPlaceholderScale = 1.10
        
        footer.textFieldFloating?.textColor = AppColor.textColor
        footer.textFieldControllerFloating?.activeColor = AppColor.placeHolderColor
        footer.textFieldControllerFloating?.normalColor = AppColor.placeHolderColor
        footer.textFieldFloating?.placeholderLabel.textColor = AppColor.themeColor
        footer.textFieldControllerFloating?.inlinePlaceholderColor = AppColor.placeHolderColor
        footer.textFieldControllerFloating?.floatingPlaceholderNormalColor = AppColor.themeColor
        footer.textFieldControllerFloating?.floatingPlaceholderActiveColor = AppColor.themeColor
        footer.textFieldFloating?.placeholder = ConstantTexts.address
        
        footer.btnEditRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 14)
        footer.btnEditRef.setTitleColor(AppColor.themeColor, for: .normal)
        footer.btnEditRef.setTitle("(Edit)", for: .normal)
        
        footer.btnAddressRef.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
        
        footer.btnEditRef.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
        
        GlobalCustomMethods.shared.provideCornarRadius(btnRef: footer.btnEditRef)
        
        
        footer.textFieldFloating?.underline?.isHidden = false
        footer.textFieldFloating?.clearButton.isHidden = false */
        
        
        footer.frame.size.height = 150
        Header.frame.size.height = 0
        
        Header.lblHeader.textColor = AppColor.textColor
        Header.lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        
        tblView.tableFooterView = footer
        tblView.tableHeaderView = Header
        
        AccessCurrentLocationuser()
        
        
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            
            if userInfo.access_token != ""{
                self.menuItemDataModelArray.removeAll()
                self.tblView.tableFooterView = UIView()
                self.tblView.tableHeaderView = UIView()
                self.btnSubmit.isHidden = true
                self.lblEmptyField.isHidden = true
               // self.macroObj.showLoaderEmpty(view: self.tblView)
                self.macroObj.hideLoaderNet(view: self.tblView)
                self.macroObj.hideWentWrong(view: self.tblView)
                getCartListService()
            }else{
                if self.menuItemDataModelArray.count > 0{
                    self.menuItemDataModelArray.removeAll()
                }
                
                var tPrice = Int()
                var tPaidPrice = Int()
                var tDiscount = Int()
                
                let orders = realm.objects(OrderItem.self)
                for order in 0..<orders.count{
                    
                    tPrice += orders[order].price
                    tDiscount += orders[order].RestaurentDiscount
                    
                    restaurentName = orders[order].RestaurentName.trimmingCharacters(in: .whitespacesAndNewlines)
                    restaurentAddress = orders[order].RestaurentAddress.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    
                    self.id = orders[order].RestaurentId
                    
                    self.menuItemDataModelArray.append(menuItemDataModel(name: orders[order].name, id: Int(orders[order].RestaurentId) ?? 0, price: orders[order].price, img: orders[order].img, description: orders[order].description, item_type: orders[order].itemType, index: order, quantity: orders[order].quantity, totalQuantity: orders[order].totolQuantity, menu_type: orders[order].menuCount, type: Int(orders[order].type) ?? 0, discount: orders[order].RestaurentDiscount, customizeDataModelArray: [CustomizesDataModel](), addon: orders[order].addOns))
                    
                    
                    if order == 0{
                       self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: orders[order].RestaurentName, subTitle: orders[order].RestaurentAddress, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                    }else{
//                        self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: orders[order].RestaurentName, subTitle: orders[order].RestaurentAddress, delemit: "", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                    }
                    
                    
                    
                }
                
                
                
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    if userInfo.id == ""{
                        price = String(tPrice - tDiscount)
                        
                       //Commented by Sonika
                        
                     /*   self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                        
                        self.footer.lblPaidValue.text = "AED \(price)"
                        
                        self.footer.lblDiscountValue.text = "AED \(tDiscount)" */
                    }
                }else{
                    price = String(tPrice - tDiscount)
                    
                //Commented by Sonika

                    /*
                    
                    self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                    
                    self.footer.lblPaidValue.text = "AED \(price)"
                    
                    self.footer.lblDiscountValue.text = "AED \(tDiscount)" */
                }
                
                
               
              
                
                
                
                if self.menuItemDataModelArray.count > 0{
                    self.macroObj.hideLoaderEmpty(view: self.tblView)
                    self.macroObj.hideWentWrong(view: self.tblView)
                    self.macroObj.hideLoaderNet(view: self.tblView)
//                    self.tblView.tableFooterView = self.footer
//                    self.tblView.tableHeaderView = self.Header
                    self.btnSubmit.isHidden = false
                    self.lblEmptyField.isHidden = true
                    self.tblView.reloadData()
                }else{
                    self.menuItemDataModelArray.removeAll()
//                    self.tblView.tableFooterView = UIView()
//                    self.tblView.tableHeaderView = UIView()
                    self.btnSubmit.isHidden = true
                    self.macroObj.showLoaderEmpty(view: self.tblView)
                    self.macroObj.hideLoaderNet(view: self.tblView)
                    self.macroObj.hideWentWrong(view: self.tblView)
                    self.lblEmptyField.isHidden = false
                    self.tblView.reloadData()
                    
                }
                
            }
        }else{
            if self.menuItemDataModelArray.count > 0{
                self.menuItemDataModelArray.removeAll()
            }
            
            var tPrice = Int()
            var tPaidPrice = Int()
            var tDiscount = Int()
            
            let orders = realm.objects(OrderItem.self)
            
        
            
          
            
           
            
            for order in 0..<orders.count{
                
                tPrice += orders[order].price
                tDiscount += orders[order].RestaurentDiscount
                
                restaurentName = orders[order].RestaurentName
                restaurentAddress = orders[order].RestaurentAddress
                
                self.menuItemDataModelArray.append(menuItemDataModel(name: orders[order].name, id: Int(orders[order].RestaurentId) ?? 0, price: orders[order].price, img: orders[order].img, description: orders[order].description, item_type: orders[order].itemType, index: order, quantity: orders[order].quantity, totalQuantity: orders[order].totolQuantity, menu_type: orders[order].menuCount, type: Int(orders[order].type) ?? 0, discount: orders[order].RestaurentDiscount, customizeDataModelArray: [CustomizesDataModel](), addon: orders[order].addOns))
                
             //   self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: orders[order].RestaurentName, subTitle: orders[order].RestaurentAddress, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
            }
            
            
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                if userInfo.id == ""{
                    
                        price = String(tPrice - tDiscount)
                    //Commented by Sonika

                    /*
                
                    self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                    
                    self.footer.lblPaidValue.text = "AED \(price)"
                    
                    self.footer.lblDiscountValue.text = "AED \(tDiscount)" */
                }
            }else{
                price = String(tPrice - tDiscount)
                
                
                    //Commented by Sonika
               /* self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                
                self.footer.lblPaidValue.text = "AED \(price)"
                
                self.footer.lblDiscountValue.text = "AED \(tDiscount)"*/
            }
            
            
            
            
            
            
            if self.menuItemDataModelArray.count > 0{
                self.macroObj.hideLoaderEmpty(view: self.tblView)
                self.macroObj.hideWentWrong(view: self.tblView)
                self.macroObj.hideLoaderNet(view: self.tblView)
                self.tblView.tableFooterView = self.footer
                self.tblView.tableHeaderView = self.Header
                self.btnSubmit.isHidden = false
                self.lblEmptyField.isHidden = true

                self.tblView.reloadData()
            }else{
                self.menuItemDataModelArray.removeAll()
                self.tblView.tableFooterView = UIView()
                self.tblView.tableHeaderView = UIView()
                self.btnSubmit.isHidden = true
                self.macroObj.showLoaderEmpty(view: self.tblView)
                self.macroObj.hideLoaderNet(view: self.tblView)
                self.macroObj.hideWentWrong(view: self.tblView)
                self.lblEmptyField.isHidden = false
                self.tblView.reloadData()
                
            }
            
            
            if orders.count > 0{
                let order = 0
                self.Header.lblHeader.text = ""
                self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: orders[order].RestaurentName, subTitle: orders[order].RestaurentAddress, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
            }
            
            
        }
        
        
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
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: MyCartVC.className)
        var firstTym = UserDefaults.standard.value(forKey: "firstTimePress") as? Bool
        
        if firstTym == false{
              super.setupNavigationBarTitle("My Cart", leftBarButtonsType: [.cartBack], rightBarButtonsType: [])
              UserDefaults.standard.set(true, forKey: "firstTimePress")
        }else{
            
            super.setupNavigationBarTitle("My Cart", leftBarButtonsType: [.back], rightBarButtonsType: [])
        }
    
    }
    
    
    internal func calladdCartMethod(index:Int,isComing:Bool){
        if self.menuItemDataModelArray[index].customizeDataModelArray.count > 0{
            
          /*  let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: SubMenuListingVC.className) as! SubMenuListingVC
            viewC.customizeDataModelArray = self.menuItemDataModelArray[index].customizeDataModelArray
            viewC.price = self.menuItemDataModelArray[index].price
            viewC.quantity = self.menuItemDataModelArray[index].quantity
            viewC.index = index
            viewC.backObjC = self
            viewC.isComing = "CART"
            if isComing{
                viewC.isNewOrder = "1"
            }else{
                viewC.isNewOrder = ""
            }
            
            self.navigationController?.present(viewC, animated: true, completion: nil)*/
           
        
            
            var isNewOrder = String()
            
            if isComing{
                isNewOrder = "1"
            }else{
                isNewOrder = ""
            }
            
            var qty = self.menuItemDataModelArray[index].quantity
            qty += 1
            self.addToCart(catId:String(self.menuItemDataModelArray[index].id),type:String(self.menuItemDataModelArray[index].type),index:index,qty:qty,price:Double(self.menuItemDataModelArray[index].price),newOreder:isNewOrder,menu_id:String(self.menuItemDataModelArray[index].id),addon:String(self.menuItemDataModelArray[index].addon), status: "plus")
            
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
            self.addToCart(catId:String(self.menuItemDataModelArray[index].id),type:String(self.menuItemDataModelArray[index].type),index:index,qty:qty,price:Double(self.menuItemDataModelArray[index].price),newOreder:isNewOrder,menu_id:String(self.menuItemDataModelArray[index].id),addon:String(self.menuItemDataModelArray[index].addon), status: "plus")
            
        }
        
        tblView.reloadData()
    }
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
       
        self.tblView.registerMultiple(nibs: [CartTableViewCellAndXib.className,eatTypeTableViewCell.className])
        
        
    }
    
    internal func getCartListService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            macroObj.showLoader(view: self.view)
            
            var xLoc = "en"
            let realm = try! Realm()
            var id = String()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            
            let haeder = ["Accept":"application/json",
                          "X-localization":xLoc]
            
            let passDict = ["user_id":id] as [String:AnyObject]
            
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.cartlist.rawValue, params: passDict, headers: haeder, success: { (resJson) in
                
                print(resJson)
                if let status = resJson["status"].stringValue as? String{
                    if status == "true"{
                        self.macroObj.hideLoader(view: self.view)
                        
                        if self.menuItemDataModelArray.count > 0{
                            self.menuItemDataModelArray.removeAll()
                        }
                        var lat = Double()
                        var long = Double()
                        var restName = String()
                        var restAdderss = String()
                       
                        if let extradetails = resJson["extra_details"].dictionaryObject as? NSDictionary{
                            
                            if let offere_details = extradetails.value(forKey: "offere_details") as?  NSArray{
                                print("the offer dertails are-->",offere_details)
                                
                                for item in 0..<offere_details.count{
                                    if let orderlistDict = offere_details[item] as? NSDictionary{
                                        var discountR = Int()
                                        var thumbnailR = String()
                                        var idR = String()
                                        var statusR = String()
                                        var valid_dateR = String()
                                        var imgR = String()
                                        var restorent_idR = String()
                                        var typeR = String()
                                        var noteR = String()
                                        if let discount = extradetails.value(forKey: "discount")  as? Int{
                                            discountR = discount
                                            print(discountR)
                                        }
                                        
                                        if let thumbnail = extradetails.value(forKey: "thumbnail")  as? String{
                                            thumbnailR = thumbnail
                                            print(thumbnailR)
                                        }
                                        
                                        if let id = extradetails.value(forKey: "id")  as? String{
                                            idR = id
                                            print(idR)
                                        }
                                        
                                        if let status = extradetails.value(forKey: "status")  as? String{
                                            statusR = status
                                            print(statusR)
                                        }
                                        if let valid_date = extradetails.value(forKey: "valid_date")  as? String{
                                            valid_dateR = valid_date
                                            print(valid_dateR)
                                        }
                                        if let img = extradetails.value(forKey: "img")  as? String{
                                            imgR = img
                                            print(statusR)
                                        }
                                        if let restorent_id = extradetails.value(forKey: "restorent_id")  as? String{
                                            restorent_idR = restorent_id
                                            print(restorent_idR)
                                        }
                                        if let type = extradetails.value(forKey: "type")  as? String{
                                            typeR = type
                                            print(typeR)
                                        }
                                        if let note = extradetails.value(forKey: "note")  as? String{
                                            noteR = note
                                            print(noteR)
                                        }
                                        
                                        let cartOfferItem = CartOfermodel(discount: discountR, thumbnail: thumbnailR, id: idR, status: statusR, valid_date: valid_dateR, img: imgR, restorent_id: restorent_idR, type: typeR, note: noteR)
                                        
                                        self.offerCartDataModel.append(cartOfferItem)
                                        print("the offer data model is-->",self.offerCartDataModel)
                                        print("order count is-->",self.offerCartDataModel.count)
                                        
                                }
                                
                            }
                        }
                            if let totalpaidamount = extradetails.value(forKey: "total_paid_amount")  as? Double{
                                
                                print(totalpaidamount)
                            }
                            if let restaurentaddress = extradetails.value(forKey: "restaurent_address")  as? String{
                                restAdderss = restaurentaddress
                                print(restaurentaddress)
                            }
                            if let usercurrentaddress = extradetails.value(forKey: "user_current_address")  as? String{
                                
                                print(usercurrentaddress)
                            }
                            
                            if let restaurentname = extradetails.value(forKey: "restaurant_name")  as? String{
                                restName = restaurentname
                                print(restaurentname)
                            }
                            if let restaurentid = extradetails.value(forKey: "restaurant_id")  as? Int{
                                self.id = String(restaurentid)
                                print(restaurentid)
                            }
                            
                            
                            
                            if let latitude = extradetails.value(forKey: "latitude")  as? String{
                                lat = Double(latitude) ?? 0.0
                                print(latitude)
                            }
                            
                            if let longitude = extradetails.value(forKey: "longitude")  as? String{
                                long = Double(longitude) ?? 0.0
                                print(longitude)
                            }
                            
                            if let offered_service = extradetails.value(forKey: "offered_service")  as? String{
                                self.offeredService = offered_service
                                print(offered_service)
                            }
                            
                            print(restName)
                            
                            self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: restName, subTitle: restAdderss, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                           
                            
                            if let totalprice = extradetails.value(forKey: "total_price")  as? Double{
                                print(totalprice)
                                self.price = String(totalprice)
                                  //Commented by Sonika
                            
                             
                            }
                            
                            if let total_paid_amount = extradetails.value(forKey: "total_paid_amount")  as? Double{
                                self.totalPrice = String(total_paid_amount)
                                  //Commented by Sonika
                            //   self.footer.lblPaidValue.text = "AED \(String(format: "%.2f", total_paid_amount))"
                                
                            }
                            
                            if let discount = extradetails.value(forKey: "discount")  as? Double{
                                self.discount = String(discount)
                                //Commented by Sonika
                              //  self.footer.lblDiscountValue.text = "AED \(String(format: "%.2f", discount))"
                                print(discount)
                            }
                            if let restaurentdescriptiom = extradetails.value(forKey: "restaurent_descriptiom")  as? String{
                                
                                print(restaurentdescriptiom)
                            }
                        }
                        
                        if let cartList = resJson["cartList"].arrayObject as? NSArray{
                            for item in 0..<cartList.count{
                                if let menulistDict = cartList[item] as? NSDictionary{
                                    var nameR = String()
                                    var idR = Int()
                                    var priceR = Int()
                                    var discountR = Int()
                                    var imgR = "http://3.8.172.240/just_bite/public/storage/menu/thumbnail/1562306432_Paleo%20Instant.jpg"
                                    var descriptionR = String()
                                    var item_typeR = Int()
                                    var quantityR = Int()
                                    var typeR = String()
                                    var addonR = String()
                                    
                                    var customizeDataModelArrayR = [CustomizesDataModel]()
                                    
                                    
                                    if let addon = menulistDict.value(forKey: "addon") as? String{
                                        addonR = addon
                                    }
                                    
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
                                    
                                    if let type = menulistDict.value(forKey: "type") as? String{
                                        typeR = type
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
                                    
                                    var addOnArray = addonR.split(separator: ",")
                                    print(addOnArray)
                                    
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
                                                            
                                                            if let name = addonsDict.value(forKey: "en_name") as? String{
                                                                nameAO = name
                                                            }
                                                            
                                                            if let id = addonsDict.value(forKey: "id") as? Int{
                                                                idAO = id
                                                            }
                                                            
                                                            if let price = addonsDict.value(forKey: "price") as? Int{
                                                                priceAO = price
                                                            }
                                                            
                                                            var flag = Bool()
                                                            
                                                            for item in 0..<addOnArray.count{
                                                                if addOnArray[item] == String(idAO){
                                                                flag = true
                                                                }
                                                            }

                                                            let addOnItem = AddOnDataModel(name: nameAO, id: idAO, price: priceAO, isSelected: flag)
                                                            
                                                            addons.append(addOnItem)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            
                                            customizeDataModelArrayR.append(CustomizesDataModel(itemHeading: itemHeadingRR, type: typeRR, variation: variationRR, addons: addons))
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    print(discountR)
                                    
                                    let itemDataModel = menuItemDataModel(name: nameR, id: idR, price: priceR, img: imgR, description: descriptionR, item_type: item_typeR, index: item, quantity: quantityR, totalQuantity: quantityR, menu_type: Int(), type: Int(typeR) ?? 0, discount: discountR, customizeDataModelArray: customizeDataModelArrayR, addon: addonR)
                                    self.menuItemDataModelArray.append(itemDataModel)
                                }
                            }
                            
                            
                            
                            
                            
                            
                           let orders = realm.objects(OrderItem.self)
                            
                           
                               
                                for order in 0..<orders.count{
                                
                                    self.restaurentName = orders[order].RestaurentName
                                    self.restaurentAddress = orders[order].RestaurentAddress
                                    
                                    let itemDataModel = menuItemDataModel(name: orders[order].name, id: orders[order].id, price: orders[order].price, img: orders[order].img, description: orders[order].description, item_type: orders[order].itemType, index: order, quantity: orders[order].quantity, totalQuantity: orders[order].totolQuantity, menu_type: orders[order].menuCount, type: Int(orders[order].type) ?? 0, discount: orders[order].RestaurentDiscount, customizeDataModelArray: [CustomizesDataModel](), addon: orders[order].addOns)
                                    self.menuItemDataModelArray.append(itemDataModel)
                                    
                                     self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: orders[order].RestaurentName, subTitle: orders[order].RestaurentAddress, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                                    
                                }
                            
                            
                            var tPrice = Int()
                            var tDiscount = Int()
                            
                            for item in self.menuItemDataModelArray{
                                tPrice = item.price
                                
                                tDiscount = item.discount
                                print(tDiscount)
                            }
                            
                            print(self.discount)
                            
                            
                            
                            if let userInfo = realm.objects(SignupDataModel.self).first{
                                if userInfo.id == ""{
                                    let doubleDiscount = Double(self.discount) as? Double ?? 0.0
                                    let intDiscount = Int(doubleDiscount) as? Int ?? 0
                                    
                                    self.price = String(tPrice - intDiscount)
                                    
                                      //Commented by Sonika
                                   /* self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                                    
                                    self.footer.lblPaidValue.text = "AED \(self.price)"
                                    
                                    self.footer.lblDiscountValue.text = "AED \(self.discount)"*/
                                }
                            }else{
                                let doubleDiscount = Double(self.discount) as? Double ?? 0.0
                                let intDiscount = Int(doubleDiscount) as? Int ?? 0
                                
                                self.price = String(tPrice - intDiscount)
                                
                                  //Commented by Sonika
                               /* self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                                
                                self.footer.lblPaidValue.text = "AED \(self.price)"
                                
                                self.footer.lblDiscountValue.text = "AED \(self.discount)"*/
                            }
                            
                            
                            
                           
                            
                            
                            
                            
                            if self.menuItemDataModelArray.count > 0{
                                self.macroObj.hideLoaderEmpty(view: self.tblView)
                                self.macroObj.hideWentWrong(view: self.tblView)
                                self.macroObj.hideLoaderNet(view: self.tblView)
                                self.tblView.tableFooterView = self.footer
                                self.tblView.tableHeaderView = self.Header
                                self.btnSubmit.isHidden = false
                                self.lblEmptyField.isHidden = true
                                self.tblView.reloadData()
                            }else{
                                self.menuItemDataModelArray.removeAll()
                                self.tblView.tableFooterView = UIView()
                                self.tblView.tableHeaderView = UIView()
                                self.btnSubmit.isHidden = true
                                self.macroObj.showLoaderEmpty(view: self.tblView)
                                self.macroObj.hideLoaderNet(view: self.tblView)
                                self.macroObj.hideWentWrong(view: self.tblView)
                                self.lblEmptyField.isHidden = false
                                self.tblView.reloadData()
                                
                            }
                            
 
 
                            
                            
                            if self.menuItemDataModelArray.count == 0{
                                
                                
                                
                                for order in 0..<orders.count{
                                    
                                    
                                        if self.menuItemDataModelArray.count > 0{
                                            self.menuItemDataModelArray.removeAll()
                                        }
                                        
                                        var tPrice = Int()
                                        var tPaidPrice = Int()
                                        var tDiscount = Int()
                                        
                                        let orders = realm.objects(OrderItem.self)
                                        for order in 0..<orders.count{
                                            
                                            tPrice += orders[order].price
                                            tDiscount += orders[order].RestaurentDiscount
                                            
                                            self.restaurentName = orders[order].RestaurentName
                                            self.restaurentAddress = orders[order].RestaurentAddress
                                            
                                            self.menuItemDataModelArray.append(menuItemDataModel(name: orders[order].name, id: Int(orders[order].RestaurentId) ?? 0, price: orders[order].price, img: orders[order].img, description: orders[order].description, item_type: orders[order].itemType, index: order, quantity: orders[order].quantity, totalQuantity: orders[order].totolQuantity, menu_type: orders[order].menuCount, type: Int(orders[order].type) ?? 0, discount: orders[order].RestaurentDiscount, customizeDataModelArray: [CustomizesDataModel](), addon: orders[order].addOns))
                                            
                                            self.Header.lblHeader.attributedText = GlobalCustomMethods.shared.attributedString(title: orders[order].RestaurentName, subTitle: orders[order].RestaurentAddress, delemit: "\n", sizeTitle: 17, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                                            
                                        }
                                    
                                    
                                    
                                    
                                    
                                    if let userInfo = realm.objects(SignupDataModel.self).first{
                                        if userInfo.id == ""{
                                            self.price = String(tPrice - tDiscount)
                                              //Commented by Sonika
                                        /*    self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                                            
                                            self.footer.lblPaidValue.text = "AED \(self.price)"
                                            
                                            self.footer.lblDiscountValue.text = "AED \(tDiscount)" */
                                        }
                                    }else{
                                        self.price = String(tPrice - tDiscount)
                                          //Commented by Sonika
                                       /* self.footer.lblTotalAmountValue.text = "AED \(tPrice)"
                                        
                                        self.footer.lblPaidValue.text = "AED \(self.price)"
                                        
                                        self.footer.lblDiscountValue.text = "AED \(tDiscount)"*/
                                    }
                                    
                                    
                                        
                                    
                                        
                                        
                                        
                                        
                                        if self.menuItemDataModelArray.count > 0{
                                            self.macroObj.hideLoaderEmpty(view: self.tblView)
                                            self.macroObj.hideWentWrong(view: self.tblView)
                                            self.macroObj.hideLoaderNet(view: self.tblView)
                                            self.tblView.tableFooterView = self.footer
                                            self.tblView.tableHeaderView = self.Header
                                            self.btnSubmit.isHidden = false
                                            self.lblEmptyField.isHidden = true
                                            self.tblView.reloadData()
                                        }else{
                                            self.menuItemDataModelArray.removeAll()
                                            self.tblView.tableFooterView = UIView()
                                            self.tblView.tableHeaderView = UIView()
                                            self.btnSubmit.isHidden = true
                                            self.macroObj.showLoaderEmpty(view: self.tblView)
                                            self.macroObj.hideLoaderNet(view: self.tblView)
                                            self.macroObj.hideWentWrong(view: self.tblView)
                                            self.lblEmptyField.isHidden = false
                                            self.tblView.reloadData()
                                            
                                        }
                                        
                                    
                                    
                                    
                                    

                                }
                            }
 
 
 
                            
                        
                            
                            
                          //  yaha karna hai
                            
                            if self.menuItemDataModelArray.count > 0{
                                self.macroObj.hideLoaderEmpty(view: self.tblView)
                                self.macroObj.hideWentWrong(view: self.tblView)
                                self.macroObj.hideLoaderNet(view: self.tblView)
                                self.tblView.tableFooterView = self.footer
                                self.tblView.tableHeaderView = self.Header
                                self.btnSubmit.isHidden = false
                                self.lblEmptyField.isHidden = true
                                self.tblView.reloadData()
                            }else{
                                self.menuItemDataModelArray.removeAll()
                                self.tblView.tableFooterView = UIView()
                                self.tblView.tableHeaderView = UIView()
                                self.btnSubmit.isHidden = true
                                self.macroObj.showLoaderEmpty(view: self.tblView)
                                self.macroObj.hideLoaderNet(view: self.tblView)
                                self.macroObj.hideWentWrong(view: self.tblView)
                                self.lblEmptyField.isHidden = false
                                self.tblView.reloadData()
                                
                            }
                        }
                        
                        
                        let camera = GMSCameraPosition.camera(withLatitude:lat ,longitude: long ,zoom:10)
                          //Commented by Sonika
                       // self.footer.mapView.camera = camera
                        let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        let marker = GMSMarker(position: position)
                        
                        marker.icon = UIImage(named: "map_location_ic")
                        marker.title = restName
                       // marker.map = self.footer.mapView
                          //Commented by Sonika
                      //  self.footer.mapView.isMyLocationEnabled = true

                    }else{
                        self.macroObj.hideLoader(view: self.view)
                        self.macroObj.hideLoaderEmpty(view: self.tblView)
                        self.macroObj.hideWentWrong(view: self.tblView)
                        self.macroObj.hideLoaderNet(view: self.tblView)
                        self.lblEmptyField.isHidden = true

                        if let message = resJson["message"].stringValue as? String{
                            _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                        }
                    }
                    
               
            }
            }) { (error) in
                print(error)
                self.macroObj.hideLoader(view: self.view)
                self.macroObj.showWentWrong(view: self.tblView)
                self.macroObj.hideLoaderEmpty(view: self.tblView)
                self.lblEmptyField.isHidden = true

                self.macroObj.hideWentWrong(view: self.tblView)
            }
            
        }else{
            macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblView)
            macroObj.hideLoaderEmpty(view: self.tblView)
            macroObj.hideWentWrong(view: self.tblView)
        }
    }

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
//                    self.menuItemDataModelArray[index].quantity = qty
//                    
//                    if self.menuItemDataModelArray[index].quantity > 0{
//                        
//                        let indexPath = IndexPath(row: index, section: 0)
//                        guard let cell = self.tblView.cellForRow(at: indexPath) as? CartTableViewCellAndXib else{
//                            print("No cell")
//                            return
//                        }
//                        cell.btnQtyRef.setTitle("\(qty)", for: .normal)
//                    }else{
//                        self.menuItemDataModelArray.remove(at: index)
//                        self.tblView.reloadData()
//                        
//                    }
                    
                 self.getCartListService()
                    
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
                self.lblEmptyField.isHidden = true

                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblView)
            macroObj.hideLoaderEmpty(view: self.tblView)
            macroObj.hideWentWrong(view: self.tblView)
            
        }
    }
    
    
    func cartdetailSave(eatOption:String,pickup_date:String,pickup_time:String,vist_date:String,vist_time:String,address:String,no_of_people:String){
           if InternetConnection.internetshared.isConnectedToNetwork(){
            
            var xLoc = "en"
            var access_token = String()
            var token_type = String()
            let realm = try! Realm()
            var Userid = String()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                
                xLoc = userInfo.xLoc
                access_token = userInfo.access_token
                token_type = userInfo.token_type
                Userid = userInfo.id
            }else{
                print("do nothing")
            }
            
            let header = ["X-localization":xLoc,
                          "Accept":"application/json",
                          "Content-Type":"application/x-www-form-urlencoded",
                          "Authorization":"\(token_type) \(access_token)"]
            
            let passDict = ["user_id":id,
                            "eat_option":eatOption,
                            "pickup_date":pickup_date,
                            "pickup_time":pickup_time,
                            "vist_date":vist_date,
                            "vist_time":vist_time,
                            "address":address,
                            "no_of_people":no_of_people
                            ] as [String:AnyObject]
            
            print(passDict)
            print(header)
            
            macroObj.showLoader(view: view)
            
              alamoFireObj.postRequestURLUndcoded(MacrosForAll.APINAME.saveCartDetail.rawValue, params: passDict, headers: header, success: {responseJson in
                
                print(responseJson)
                }
                , failure: { (error) in
                    self.macroObj.hideLoader(view: self.view)
                    print(error.localizedDescription)
                    _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
                    self.macroObj.showWentWrong(view: self.tblView)
                    self.macroObj.hideLoaderEmpty(view: self.tblView)
                    self.macroObj.hideLoaderNet(view: self.tblView)
                    self.lblEmptyField.isHidden = true
                    
                    
              })
           }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.tblView)
            macroObj.hideLoaderEmpty(view: self.tblView)
            macroObj.hideWentWrong(view: self.tblView)
        }
    }
    
    internal func placeOrderService(transaction_id:String, landmark: String, pincode: String, lat: String, long: String){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var xLoc = "en"
            let realm = try! Realm()
            var permanentAddress = String()
            var id = String()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
                permanentAddress = userInfo.address
                
            }else{
                print("do nothing")
            }
            
            if address == ""{
                address = permanentAddress
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    area = userInfo.area
                    user_current_address = permanentAddress
                    pin = userInfo.pin
                    
                }else{
                    print("do nothing")
                }
                
                
                
            }else{
                user_current_address = address
            }
            
            
            //            let header = ["X-localization":xLoc,
            //                          "Accept":"application/json"]
            
            //            let passDict = ["user_id":id as AnyObject,
            //                            "payment_type":payment_type,
            //                            "user_current_address":"Mobulous Technology Pvt. Ltd. H-146/H-147 Noida U.P.",
            //                            "area":area,
            //                            "address":address,
            //                            "pin":pin,
            //                            "latitude":19.01761470,
            //                            "longitude":72.85616440,
            //                            "extra_notes":extra_notes,
            //                            "price":price,
            //                            "discount":discount,
            //                            "totalPrice":totalPrice] as [String:AnyObject]
            
            
            //   ["totalPrice": 177.1, "pin": , "latitude": 28.625730864573764, "address": , "user_id": 61, "area": , "price": 0, "discount": 75.9, "longitude": 77.37761082125864, "user_current_address": , "extra_notes": , "payment_type": COD]
            
            
            
            
            let passDict = ["user_id":id as AnyObject,
                            "payment_type":"online",
                            "user_current_address":self.user_current_address,
                            "area":address,
                            "address":address,
                            "pin":pincode,
                            "latitude":lat,
                            "longitude":long,
                            "extra_notes":"hello",
                            "price":price,
                            "discount":discount,
                            "totalPrice":totalPrice,
                            "transaction_id":transaction_id] as [String:AnyObject]
            print(passDict)
            
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.placeOrder.rawValue, params: passDict as [String : AnyObject], headers: nil, success: { (responseJASON) in
                
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                
                
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
                    }
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    // self.macroObj.appDelegate.openDrawer1()
                    
                    
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
    
}


extension MyCartVC:UITextViewDelegate{
    
  //Commented by Sonika
    
  /*  func textViewDidBeginEditing(_ textView: UITextView) {
        if (footer.txtView.text == "Add extra note...")
            
        {
            footer.txtView.text = nil
            footer.txtView.textColor = AppColor.textColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if footer.txtView.text.isEmpty
        {
            footer.txtView.text = "Add extra note..."
            footer.txtView.textColor = AppColor.placeHolderColor
        }
        textView.resignFirstResponder()
    }*/
    
    func reverseGeocodeCoordinate(inLat:Double, inLong:Double) {
        
        let cordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: inLat, longitude: inLong)
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(cordinate) { response, error in
            
            if let address = response?.results() {
                
                let lines = address.first
                
                print(lines)
                
                if let addressNew = lines?.lines {
                      //Commented by Sonika
                //    self.footer.textFieldFloating?.text = self.makeAddressString(inArr: addressNew)
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


//MARK: - Extension Location Delegates
extension MyCartVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.latitude = String(currentLocation.coordinate.latitude)
        self.longitude = String(currentLocation.coordinate.longitude)
        reverseGeocodeCoordinate(inLat:currentLocation.coordinate.latitude, inLong:currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension MyCartVC: CLLocationManagerDelegate {
    
    func AccessCurrentLocationuser(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }else{
            let locationAlert = UIAlertController(title: "Data Collection", message: "GPS is not enabled. Do you want to go to settings menu?", preferredStyle: UIAlertController.Style.alert)
            locationAlert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { (alert: UIAlertAction!) in
                UIApplication.shared.openURL(NSURL(string:UIApplication.openSettingsURLString)! as URL)
            }))
            locationAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction) in}))
            self.present(locationAlert, animated: true, completion: nil)
        }
    }
}
