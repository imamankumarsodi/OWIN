//
//  MyCartVC.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import GoogleMaps
import CoreLocation
import RealmSwift
import Braintree
import SwiftyJSON

class MyCartVC: BaseViewController,BackToCartAdd {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var heightHeader: NSLayoutConstraint!
    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var lblEmptyField: UILabel!
    
    //MARK:- All Propetise
    let realm = try! Realm()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var menuItemDataModelArray = [menuItemDataModel]()
    var offerCartDataModel = [CartOfermodel]()
    var textFieldControllerFloating: MDCTextInputControllerUnderline?
    var id = String()
    var restaurentName = String()
    var restaurentAddress = String()
    var locationManager:CLLocationManager!
    let footer:ViewFooterForCartChoice = Bundle.main.loadNibNamed("ViewFooterForCartChoice", owner: self, options: nil)!.last! as! ViewFooterForCartChoice
    
    let Header:CartHeaderView = Bundle.main.loadNibNamed("CartHeaderView", owner: self, options: nil)!.first! as! CartHeaderView
    var offered0 = [" Pick Up"]
    var offered1 = [" Home Delivery"]
    var offered2 = [" Eat At Restaurant"]
    var offered0_1 =  [" Pick Up"," Home Delivery"]
    var offered0_2 =  [" Pick Up"," Eat At Restaurant"]
    var offered1_2 =  [" Home Delivery"," Eat At Restaurant"]
    var eatArray =  [" Pick Up"," Home Delivery"," Eat At Restaurant"]
    
    var eatArray0 = [Bool()]
    var eatArray1 = [Bool()]
    var eatArray2 = [Bool()]
    var eatArray0_1 = [Bool(),Bool()]
    var eatArray0_2 = [Bool(),Bool()]
     var eatArray1_2 = [Bool(),Bool()]
    var eatArrayInt = [Bool(),Bool(),Bool()]
    var offeredService = String()
    
    let Homefooter:HomeDeleiveryFooterView = Bundle.main.loadNibNamed("HomeDeleiveryFooterView", owner: self, options: nil)!.last! as! HomeDeleiveryFooterView
    
    let Pickfooter:PickUpFooterView = Bundle.main.loadNibNamed("PickUpFooterView", owner: self, options: nil)!.last! as! PickUpFooterView
    
    
    let Resturantfooter:EatResFooterView = Bundle.main.loadNibNamed("EatResFooterView", owner: self, options: nil)!.last! as! EatResFooterView
    
    
    var user_current_address = String()
    var landmark = String()
    var area = String()
    var address = String()
    var pin = String()
    var latitude = String()
    var longitude = String()
    var extra_notes = String()
    var price = String()
    var discount = String()
    var totalPrice = String()
    var selectionType = String()
    var eatOption = String()
    
    var currentLatitude = String()
    var currentLongitude = String()
    
     var braintreeClient: BTAPIClient!

    internal var openType = -1
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - View life cycle methods
    //TODO: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: "firstTimePress")
        print("the lattude is->",self.latitude)
        print("the longitude is->",self.longitude)
        // Do any additional setup after loading the view.
        initialSetup()
        braintreeClient = BTAPIClient(authorization: "sandbox_pg25z2z4_p9jgnr2gz7n42ppv")!
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    //TODO: View Will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
         self.tabBarController?.tabBar.isHidden = true
         initialSetup()
        
        if MAIN_SCREEN_HEIGHT == 812 || MAIN_SCREEN_HEIGHT == 896{
            heightHeader.constant = 90
        }else{
            heightHeader.constant = 60
            
        }
        navigationSetUpView()
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
        navigationSetUpView()
        
        if MAIN_SCREEN_HEIGHT == 812 || MAIN_SCREEN_HEIGHT == 896{
            heightHeader.constant = 90
        }else{
            heightHeader.constant = 60
            
        }
        
    }
    
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
  
    
    @IBAction func btnHeaderTapped(_ sender: UIButton) {
        
        if sender.tag == 1{
            super.backButtonTapped()
        }else{
            
           if ConstantTexts.screenName == "HomeVC"{
            
            
            
             if self.id == ""{
//                let viewController = AppStoryboard.tabbarClass as! TabBarViewC
//                let navigationController = UINavigationController(rootViewController: viewController)
//                viewController.selectedIndex = 0
//                navigationController.navigationBar.isHidden = true
//                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = navigationController
//
//                APPLICATION.keyWindow?.rootViewController = navigationController
                
                super.goBackToIndex(1, animated: true)
                
             }
             else{
                
                if menuItemDataModelArray.count > 0{
                    let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
                    vc.id = self.id
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                   self.navigationController?.popToRootViewController(animated: true)
                }
                
               
            }
            
           }else{
            
            if self.id == ""{
                self.navigationController?.popToRootViewController(animated: true)
            }
            else{
                if menuItemDataModelArray.count > 0{
                    let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
                    vc.id = self.id
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            
            }
            
            
            
        }
    }
    
    @IBAction func btnConfirmRef(_ sender: UIButton) {
        
        
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            
            if userInfo.access_token != ""{
                
                
                if userInfo.address == "" || userInfo.phone == ""{
                     _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.completeAdress, style: AlertStyle.error)
                }else{
                    

                    if self.selectionType == "Home Delivery"{
                        if Homefooter.addressTV.text == ""{
                              _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: "Please fill required detials.", style: AlertStyle.error)
                        }else{
                            cartdetailSave(eatOption: "1", pickup_date: "", pickup_time: "", vist_date: "", vist_time: "", address: self.Homefooter.addressTV.text!,no_of_people:"")
                            self.btnSubmit.backgroundColor = AppColor.stepperColor
                            self.btnSubmit.setTitle("Submit", for: .normal)
                            self.btnSubmit.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                            self.PayPal()
                        }
                   
                    }
                    else if self.selectionType == "Pick Up"{
                        if Pickfooter.dateTf.text == "" || Pickfooter.timeTf.text == ""{
                              _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: "Please fill required detials.", style: AlertStyle.error)
                        }else{
                             cartdetailSave(eatOption: "0", pickup_date: self.Pickfooter.dateTf.text!, pickup_time: self.Pickfooter.timeTf.text!, vist_date: "", vist_time: "", address: "",no_of_people:"")
                            self.btnSubmit.backgroundColor = AppColor.stepperColor
                            self.btnSubmit.setTitle("Submit", for: .normal)
                            self.btnSubmit.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                            self.PayPal()
                        }
                        
                    
                    }
                    else{
                        if Resturantfooter.dateTf.text == "" || Resturantfooter.timeTf.text == "" || Resturantfooter.peoplequantityTf.text == ""{
                             _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: "Please select Eat Option", style: AlertStyle.error)
                        }else{
                              cartdetailSave(eatOption: "2", pickup_date: "", pickup_time: "", vist_date: self.Resturantfooter.dateTf.text!, vist_time: self.Resturantfooter.timeTf.text!, address: "",no_of_people:self.Resturantfooter.peoplequantityTf.text!)
                            self.btnSubmit.backgroundColor = AppColor.stepperColor
                            self.btnSubmit.setTitle("Submit", for: .normal)
                            self.btnSubmit.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                            self.PayPal()
                        }
                      
                    }
                    
                    
                }
                
               
                
            }else{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        print("Cancel Button  Pressed", terminator: "")
                    }
                    else
                    {
                        super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                    }
                    
                }
            }
        }else{
            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    print("Cancel Button  Pressed", terminator: "")
                }
                else
                {
                    super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                }
                
            }
        }
     
    }
    
    //TODO :- forpayment in paypal
    func PayPal(){
        // Specify the transaction amount here. "2.32" is used in this example.
        let request = BTPayPalRequest(amount: self.totalPrice)
        request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
        
        print(braintreeClient)
        let payPalDriver = BTPayPalDriver(apiClient:BTAPIClient(authorization: "sandbox_pg25z2z4_p9jgnr2gz7n42ppv")!)
        print(payPalDriver)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self
        
        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
              
                let jsonObject = JSON(request)
                  print("json token account-->",jsonObject)
                
                let realm = try! Realm()
                var id = String()
                var firstName = String()
                 var lastName = String()
                 var email = String()
                 var phone = String()
                var billingAddress = String()
                
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    firstName = userInfo.first_name
                     lastName = userInfo.last_name
                     email = userInfo.email_id
                     phone = userInfo.phone
                    billingAddress = userInfo.address
                }else{
                    print("do nothing")
                }
                
                // Access additional information
                email = tokenizedPayPalAccount.email ?? ""
                print("the mail is -->",email)
                
                firstName = tokenizedPayPalAccount.firstName ?? ""
                print("the first name is -->",firstName)

                lastName = tokenizedPayPalAccount.lastName ?? ""
                print("the lastName is -->",lastName)

                phone = tokenizedPayPalAccount.phone ?? ""
                print("the phone number is -->",phone)
                
                let payPalId = tokenizedPayPalAccount.payerId ?? ""
                print("the player id is -->",payPalId)
                
                
              
                // See BTPostalAddress.h for details
                
               // var  billingAddress = UserDefaults.standard.value(forKey: "address") as? Any
                
                print(billingAddress)
                
                let abc = tokenizedPayPalAccount.billingAddress as? BTPostalAddress
                
                let xyzcity = abc?.value(forKey: "city") as? String ?? ""
                
                print(xyzcity)
                
                //MARK: place oredr api hit
                self.placeOrderService(transaction_id:tokenizedPayPalAccount.nonce, landmark: "", pincode: self.pin, lat: self.latitude, long: self.longitude)
                
            } else if let error = error {
                // Handle error here...
                print("Got an error")
            } else {
                // Buyer canceled payment approval
                print("buyer paymrnt cancel")
            }
        }
    }
    
    @objc func tapSectionBtn(sender:UIButton){
        
        let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: EditAddressPopUPVC.className) as! EditAddressPopUPVC
        
        // viewC.sendDataHomeObj = self
        //                viewC.isComing = "EDT_ADDRESS"
        //                viewC.backEditAddressObj = self
        viewC.BackToCartAddObj = self
        self.navigationController?.pushViewController(viewC, animated: false)
        
        
        
        //        let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LocationPickerVC.className) as! LocationPickerVC
        //        // viewC.sendDataHomeObj = self
        //        viewC.isComing = "EDT_ADDRESS"
        //        viewC.backEditAddressObj = self
        //        self.navigationController?.pushViewController(viewC, animated: true)
        
    }
    
    @objc func customizeTapped(sender:UIButton){
        let orders = realm.objects(OrderItem.self)
        
        if orders.count != 0{
            callAddCartLocalyMethod(index:sender.tag,isComing:false, qty: self.menuItemDataModelArray[sender.tag].quantity, addon: self.menuItemDataModelArray[sender.tag].addon, action: "ADD")
        }else{
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                
                if userInfo.access_token != ""{
                    self.calladdCartMethod(index:sender.tag, isComing: false)
                }else{
                    callAddCartLocalyMethod(index:sender.tag,isComing:false, qty: self.menuItemDataModelArray[sender.tag].quantity, addon: self.menuItemDataModelArray[sender.tag].addon, action: "ADD")
                }
            }else{
                
                callAddCartLocalyMethod(index:sender.tag,isComing:false, qty: self.menuItemDataModelArray[sender.tag].quantity, addon: self.menuItemDataModelArray[sender.tag].addon, action: "ADD")
                
            }
        }
     
    }
    
     @objc func eatOptionbtnTapped(sender:UIButton){

       /* for index in 0..<eatArrayInt.count{
            if index == sender.tag{
                eatArrayInt[index] = !eatArrayInt[index]
                if eatArrayInt[index] == true{
                    openType = sender.tag
                }else{
                    openType = -1
                }
                
            }else{
                eatArrayInt[index] = false
            }
        } */
        
        openType = sender.tag
        let indexPath = IndexPath(row: sender.tag, section: 1)
        if let cell = tblView.cellForRow(at: indexPath) as? eatTypeTableViewCell{
            self.selectionType = cell.eatOptionbtn.titleLabel?.text?.trimmingCharacters(in: .whitespaces) ?? ""
           
        }
        self.tblView.reloadData()
    }
    
    
    @objc func btnCouponTappedTapped(_ sender: UIButton) {
        
      
        let vc = AppStoryboard.pops.instantiateViewController(withIdentifier: cartOfferListViewController.className) as! cartOfferListViewController
      // vc.offerArray = offerCartDataModel
        self.navigationController?.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    
    @objc func minusTapped(sender:UIButton){
         let orders = realm.objects(OrderItem.self)
        if orders.count != 0{
            var qty = menuItemDataModelArray[sender.tag].quantity
            qty -= 1
            callAddCartLocalyMethod(index:sender.tag,isComing:false, qty: qty, addon: String(), action: "MINUS")
        }else{
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                
                if userInfo.access_token != ""{
                    var qty = menuItemDataModelArray[sender.tag].quantity
                    if qty == 0{
                        print("Do nothing")
                    }else{
                        qty -= 1
                        addToCart(catId:String(menuItemDataModelArray[sender.tag].id),type:String(menuItemDataModelArray[sender.tag].type),index:sender.tag,qty:qty,price:Double(menuItemDataModelArray[sender.tag].price),newOreder:String(),menu_id:String(menuItemDataModelArray[sender.tag].id),addon:String(menuItemDataModelArray[sender.tag].addon), status: "minus")
                    }
                }else{
                    var qty = menuItemDataModelArray[sender.tag].quantity
                    qty -= 1
                    callAddCartLocalyMethod(index:sender.tag,isComing:false, qty: qty, addon: String(), action: "MINUS")
                }
            }else{
                var qty = menuItemDataModelArray[sender.tag].quantity
                qty -= 1
                callAddCartLocalyMethod(index:sender.tag,isComing:false, qty: qty, addon: String(), action: "MINUS")
                
            }
        }
        
        
       
        
        
       
        
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        macroObj.hideLoaderEmpty(view: self.tblView)
        macroObj.hideLoaderNet(view: self.tblView)
        macroObj.hideWentWrong(view: self.tblView)
        
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            
            if userInfo.access_token != ""{
                getCartListService()
            }else{
                print("pop up dikha do login wala")
            }
        }else{
            
            print("Do nothing")
            
        }
        
        
        refreshControl.endRefreshing()
    }
    
    func backToAddCart(area: String, landmark: String, pincode: String, address: String, lat: String, long: String) {
        self.area = area
        self.landmark = landmark
        self.pin = pincode
        self.address = address
          //Commented by Sonika
        //self.footer.textFieldFloating?.text = address
        self.latitude = lat
        self.longitude = long
        getCartListService()
    }
    
    
}


extension MyCartVC:BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}


extension MyCartVC:BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}



