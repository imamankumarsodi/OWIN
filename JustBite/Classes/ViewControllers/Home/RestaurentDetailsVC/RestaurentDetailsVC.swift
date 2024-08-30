//
//  RestaurentDetailsVC.swift
//  JustBite
//
//  Created by Aman on 13/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import Cosmos
import RealmSwift
import CoreLocation


class RestaurentDetailsVC: BaseViewController,backToRestDetials,BackDataToRetDetails,BackDataToRetDetailsFilter {
   
    
    
   
    var locationManager = CLLocationManager()
    var lat = String()
    var long = String()
    //MARK: - Outlets
    
    @IBOutlet weak var disLbl: UILabel!
    @IBOutlet weak var btnCancelSearchRef: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var lblMinOrder: UILabel!
    @IBOutlet weak var lblDeliveryTime: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var heightConstraints: NSLayoutConstraint!
    @IBOutlet weak var tblCart: UITableView!
    @IBOutlet weak var collectionViewHeader: UICollectionView!
    @IBOutlet weak var btnConfirmRef: UIButton!
    @IBOutlet weak var reviewsRef: UILabel!
    
    @IBOutlet weak var imgRestaurent: UIImageView!
    
    @IBOutlet weak var heigntConsBtn: NSLayoutConstraint!
    @IBOutlet weak var viewCosmos: CosmosView!
    
    @IBOutlet weak var btnFavRef: UIButton!
    //MARK: - Variables
    internal var previousOffset: CGFloat = 0
    var id = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var isFav = String()
    var categoryDataModelArray = [CategoryDataModel]()
    var menuItemDataModelArray = [menuItemDataModel]()
    var index = Int()
    var price = Int()
    var quantity = Int()
    var addOn = String()
    var cart_value = Int()
    var catIndex = Int()
    var isSearchBarHidden = Bool()
    var searchActive = Bool()
    var filterMenuDataArray = [menuItemDataModel]()
    
    
    //TODO: FOR REALM
    var restaurentName = String()
    var restaurentAddress = String()
    var restaurentLat = String()
    var restaurentLong = String()
    let realm = try! Realm()
    var comingLat = String()
    var comingLong = String()
    
    var currentLat = String()
    var currentLong = String()
    
  //  var ordars: Results<OrderItem>?
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        // Do any additional setup after loading the view.
         self.tabBarController?.tabBar.isHidden = true
        AccessCurrentLocationuser()
        print(self.lat)
        print(self.long)
        
      
      disLbl.text =  getDistanceFromCurrentToAll(currentLocationLat:Double(currentLat) ?? 0.0,currentLocationLong:Double(currentLong) ?? 0.0,latitude:comingLat,longitude:comingLong)
        self.initialSetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationSetup()
       //  self.initialSetup()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
     //   gradientLayer.frame = self.GradinetView.bounds
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func locationBtn(_ sender: Any) {
        print(currentLat)
        print(currentLong)
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(currentLat),\(currentLong)&directionsmode=driving")! as URL)
            
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    }
        
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        
        let vc = AppStoryboard.remain.instantiateViewController(withIdentifier: RatingAndReviewsVC.className) as! RatingAndReviewsVC
        vc.id = self.id
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        // super.moveToNextViewC(name: "Remaining", withIdentifier: RatingAndReviewsVC.className)
    }
    
    
    @objc func customizeTapped(sender:UIButton){
        
        if searchActive{
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                if userInfo.id == ""{
                    if filterMenuDataArray[sender.tag].customizeDataModelArray.count == 0{
                        let qty = filterMenuDataArray[sender.tag].quantity + 1
                        addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                    }else{
                        
                        self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                    }
                    
                    
                }else{
                    self.calladdCartMethod(index:sender.tag, isComing: false, userType: "USER")
                }
            }else{
                let realm = try! Realm()
                if let userInfo = realm.objects(OrderItem.self).first{
                    
                    if userInfo.RestaurentId != id{
                        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.WantToChangeRest, style: AlertStyle.warning, buttonTitle:ConstantTexts.no, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.yes,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                            if isOtherButton == true {
                                print("Do nothing")
                            }
                            else
                            {
                                if self.filterMenuDataArray[sender.tag].customizeDataModelArray.count == 0{
                                    let qty = self.filterMenuDataArray[sender.tag].quantity + 1
                                    self.addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                                }else{
                                    
                                    self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                                }
                            }
                            
                        }
                        
                    }else{
                        if self.filterMenuDataArray[sender.tag].customizeDataModelArray.count == 0{
                            let qty = self.filterMenuDataArray[sender.tag].quantity + 1
                            self.addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                        }else{
                            
                            self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                        }
                    }
                    
                    
                    
                }else{
                    if self.filterMenuDataArray[sender.tag].customizeDataModelArray.count == 0{
                        let qty = self.filterMenuDataArray[sender.tag].quantity + 1
                        self.addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                    }else{
                        
                        self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                    }
                }
                
                
                
                
                
            }
            
            
            updateCart()
            

        }else{
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                if userInfo.id == ""{
                    if menuItemDataModelArray[sender.tag].customizeDataModelArray.count == 0{
                        let qty = menuItemDataModelArray[sender.tag].quantity + 1
                        addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                    }else{
                        
                        self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                    }
                    
                    
                }else{
                    self.calladdCartMethod(index:sender.tag, isComing: false, userType: "USER")
                }
            }else{
                let realm = try! Realm()
                if let userInfo = realm.objects(OrderItem.self).first{
                    
                    if userInfo.RestaurentId != id{
                        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.WantToChangeRest, style: AlertStyle.warning, buttonTitle:ConstantTexts.no, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.yes,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                            if isOtherButton == true {
                                print("Do nothing")
                            }
                            else
                            {
                                if self.menuItemDataModelArray[sender.tag].customizeDataModelArray.count == 0{
                                    let qty = self.menuItemDataModelArray[sender.tag].quantity + 1
                                    self.addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                                }else{
                                    
                                    self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                                }
                            }
                            
                        }
                        
                    }else{
                        if self.menuItemDataModelArray[sender.tag].customizeDataModelArray.count == 0{
                            let qty = self.menuItemDataModelArray[sender.tag].quantity + 1
                            self.addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                        }else{
                            
                            self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                        }
                    }
                    
                    
                    
                }else{
                    if self.menuItemDataModelArray[sender.tag].customizeDataModelArray.count == 0{
                        let qty = self.menuItemDataModelArray[sender.tag].quantity + 1
                        self.addMinusToOrders(qty:qty,isComing:"ADD",index:sender.tag, addon: String())
                    }else{
                        
                        self.calladdCartMethod(index:sender.tag, isComing: false, userType: "GUEST")
                    }
                }
                
                
                
                
                
            }
            
            
            updateCart()
            

        }
        
        
        
      
    }
    
    
    @objc func minusTapped(sender:UIButton){
        
        
        if searchActive{
            
            
            
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                if userInfo.id == ""{
                    
                    if self.filterMenuDataArray[sender.tag].customizeDataModelArray.count > 0{
                        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.removeItem, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                            if isOtherButton == true {
                                print("Cancel Button  Pressed", terminator: "")
                            }
                            else
                            {
                                super.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
                            }
                            
                        }
                        
                    }else{
                        let qty = filterMenuDataArray[sender.tag].quantity - 1
                        addMinusToOrders(qty:qty,isComing:"MINUS",index:sender.tag, addon: String())
                    }
                    
                    
                    
                    
                }else{
                    let qty = filterMenuDataArray[sender.tag].quantity
                    if qty == 0{
                        
                    }else{
                        if self.filterMenuDataArray[sender.tag].customizeDataModelArray.count > 0{
                            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.removeItem, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                                if isOtherButton == true {
                                    print("Cancel Button  Pressed", terminator: "")
                                }
                                else
                                {
                                    super.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
                                }
                                
                            }
                            
                        }else{
                            var qty = filterMenuDataArray[sender.tag].quantity
                            if qty == 0{
                                print("Do nothing")
                            }else{
                                qty -= 1
                                
                                //  print(self.categoryDataModelArray[sender.tag].type)
                                addToCart(catId:String(categoryDataModelArray[self.index].id),type:String(categoryDataModelArray[self.index].type),index:sender.tag,qty:qty,price:Double(filterMenuDataArray[sender.tag].price),newOreder:String(),menu_id:String(filterMenuDataArray[sender.tag].id),addon:String(), status: "minus")
                            }
                        }
                    }
                }
            }else{
                
                if self.filterMenuDataArray[sender.tag].customizeDataModelArray.count > 0{
                    _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.removeItem, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                        if isOtherButton == true {
                            print("Cancel Button  Pressed", terminator: "")
                        }
                        else
                        {
                            super.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
                        }
                        
                    }
                    
                }else{
                    let qty = filterMenuDataArray[sender.tag].quantity - 1
                    addMinusToOrders(qty:qty,isComing:"MINUS",index:sender.tag, addon: String())
                }
                
                
                
                
            }
            
            
            
        }else{
            let realm = try! Realm()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                if userInfo.id == ""{
                    
                    if self.menuItemDataModelArray[sender.tag].customizeDataModelArray.count > 0{
                        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.removeItem, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                            if isOtherButton == true {
                                print("Cancel Button  Pressed", terminator: "")
                            }
                            else
                            {
                                super.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
                            }
                            
                        }
                        
                    }else{
                        let qty = menuItemDataModelArray[sender.tag].quantity - 1
                        addMinusToOrders(qty:qty,isComing:"MINUS",index:sender.tag, addon: String())
                    }
                    
                    
                    
                    
                }else{
                    let qty = menuItemDataModelArray[sender.tag].quantity
                    if qty == 0{
                        
                    }else{
                        if self.menuItemDataModelArray[sender.tag].customizeDataModelArray.count > 0{
                            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.removeItem, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                                if isOtherButton == true {
                                    print("Cancel Button  Pressed", terminator: "")
                                }
                                else
                                {
                                    super.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
                                }
                                
                            }
                            
                        }else{
                            var qty = menuItemDataModelArray[sender.tag].quantity
                            if qty == 0{
                                print("Do nothing")
                            }else{
                                qty -= 1
                                
                                //  print(self.categoryDataModelArray[sender.tag].type)
                                addToCart(catId:String(categoryDataModelArray[self.index].id),type:String(categoryDataModelArray[self.index].type),index:sender.tag,qty:qty,price:Double(menuItemDataModelArray[sender.tag].price),newOreder:String(),menu_id:String(menuItemDataModelArray[sender.tag].id),addon:String(), status: "minus")
                            }
                        }
                    }
                }
            }else{
                
                if self.menuItemDataModelArray[sender.tag].customizeDataModelArray.count > 0{
                    _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.removeItem, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                        if isOtherButton == true {
                            print("Cancel Button  Pressed", terminator: "")
                        }
                        else
                        {
                            super.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
                        }
                        
                    }
                    
                }else{
                    let qty = menuItemDataModelArray[sender.tag].quantity - 1
                    addMinusToOrders(qty:qty,isComing:"MINUS",index:sender.tag, addon: String())
                }
                
                
                
                
            }
        }
        
        
        
   
    }
    
    
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        //filterStatus = false
        macroObj.hideLoaderEmpty(view: self.tblCart)
        macroObj.hideLoaderNet(view: self.tblCart)
        macroObj.hideWentWrong(view: self.tblCart)
        let realm = try! Realm()
        var id = String()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            id = userInfo.id
        }else{
            print("do nothing")
        }
        self.menulisService(catId:categoryDataModelArray[index].id,type:categoryDataModelArray[index].type,index:index)
        
        refreshControl.endRefreshing()
    }
    
    @IBAction func btnSearchTapped(_ sender: UIButton) {
        
        isSearchBarHidden = true
        searchBar.isHidden = false
        btnCancelSearchRef.isHidden = false
        
        
        
    }
    
    @IBAction func btnCancelSearchTapped(_ sender: UIButton) {
        
        self.searchBar.endEditing(true)
        isSearchBarHidden = false
        searchBar.isHidden = true
        btnCancelSearchRef.isHidden = true
        searchActive = false
        searchBar.text = String()
        tblCart.reloadData()
        
    }
    
    
    @IBAction func btnInfoTapped(_ sender: Any) {
        
        let vc = AppStoryboard.pops.instantiateViewController(withIdentifier: RestaurentInfoVC.className) as! RestaurentInfoVC
        vc.viewC = self
        vc.id = self.id
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnFilterTapped(_ sender: UIButton) {
        
        let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: MenuItemsVC.className) as! MenuItemsVC
        viewC.categoryDataModelArray = self.categoryDataModelArray
        viewC.protObj = self
        self.navigationController?.present(viewC, animated: true, completion: nil)
    }
    
    
    @IBAction func btnFilterTapped1(_ sender: UIButton) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: NewFilterVCAman.className) as! NewFilterVCAman
        vc.resturantid = self.id
        vc.delegateFilter = self 
        self.navigationController?.pushViewController(vc, animated: true)
     
    }
    
    
    @IBAction func btnAddToCartTapped(_ sender: UIButton) {
        
        super.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
        
    }
    
    @IBAction func btnFavTapped(_ sender: UIButton) {
        
        print(sender.tag)
        
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            //api call kara do
            
            
            if userInfo.access_token != ""{
                let token_type = userInfo.token_type
                let access_token = userInfo.access_token
                
                addFavService(token_type: token_type, access_token: access_token, view: self.viewLike, id: self.id, isFav: self.isFav)
            }else{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        print("Cancel Button  Pressed", terminator: "")
                    }
                    else
                    {
                        self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                    }
                    
                }
            }
            
            
            
            
        }else{
            
            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    print("Cancel Button  Pressed", terminator: "")
                    //                        self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                }
                else
                {
                    self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                }
                
            }
            
        }
        
        
        
    }
    
    func sendDataBack(index: Int, price: Double, addon: String, isNewOrder: String,userType: String,catIndex:Int){
        
        
        if userType == "GUEST"{
            
          print("customize wala kaam karana hai.....")
            
            self.index = index
            self.price = Int(price)
            self.addOn = addon
            print(index)
            print(price)
            print(addon)
            
            let qty = menuItemDataModelArray[index].quantity + 1
            print(qty)
            addCustomizeOrederToRealm(qty:qty,isComing:"ADD",index:index,addon:addon,catIndex:catIndex)
            
            
        }else{
            self.index = index
            self.price = Int(price)
            self.addOn = addon
            print(index)
            print(price)
            print(addon)
            
            
            var qty = menuItemDataModelArray[index].quantity
            qty += 1
            
//            print(index)
//            print(categoryDataModelArray.count)
//            for cat in categoryDataModelArray{
//                print(cat.name)
//            }
            
            print(categoryDataModelArray[catIndex].type)
            addToCart(catId:String(categoryDataModelArray[catIndex].id),type:String(categoryDataModelArray[catIndex].type),index:index,qty:qty,price:price,newOreder:isNewOrder,menu_id:String(menuItemDataModelArray[index].id),addon:addon, status: "plus")
            
        }
        
        
       
    }
    
    
    func backDataToDetilsReload(index1:Int) {
        self.catIndex = index1
        
        if categoryDataModelArray.contains(where: {$0.isSelected == true}){
            if let index = categoryDataModelArray.firstIndex(where: {$0.isSelected == true}){
                categoryDataModelArray[index].isSelected = false
                categoryDataModelArray[index1].isSelected = true
                
                let realm = try! Realm()
                var id = String()
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    id = userInfo.id
                }else{
                    print("do nothing")
                }
                self.menulisService(catId:categoryDataModelArray[index1].id,type:categoryDataModelArray[index1].type,index:index1)
            }
        }
        
        
        
        
    }
    
}


//MARK: - Extension Location Delegates
extension RestaurentDetailsVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.lat = String(currentLocation.coordinate.latitude)
        self.long = String(currentLocation.coordinate.longitude)
        
       // reverseGeocodeCoordinate(inLat:currentLocation.coordinate.latitude, inLong:currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension RestaurentDetailsVC: CLLocationManagerDelegate {
    
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
    
    func getDistanceFromCurrentToAll(currentLocationLat:Double,currentLocationLong:Double,latitude:String,longitude:String) -> String{
        
        print(currentLocationLat)
        print(currentLocationLong)
        print(latitude)
        print(longitude)
        
        if currentLocationLat == 0.0 || currentLocationLong == 0.0{
            
            return "0 KM"
        }
        
        let lati = latitude.trimmingCharacters(in: .whitespaces)
        let longi = longitude.trimmingCharacters(in: .whitespaces)
        
        if lati == "" || longi == ""{
            
            return "0 KM"
        }
        
        let doubleLat = Double(lati)
        let doubleLong = Double(longi)
        
        let coordinate₀ = CLLocation(latitude: currentLocationLat, longitude: currentLocationLong)
        
        let coordinate₁ = CLLocation(latitude: doubleLat!, longitude: doubleLong!)
        
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        let distanceInKm = distanceInMeters / 1000
        
        var integerDistance = Int()
        
        if distanceInKm < 1.0 && distanceInKm > 0.0{
            
            integerDistance = 1
        }
        else{
            
            integerDistance = Int(distanceInKm)
        }
        
        return "\(integerDistance) KM"
        
    }
    
}
