//
//  PaymentModeVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
import RealmSwift


class PaymentModeVC: BaseViewController,backToPaymentMode {
   
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblJustBiteCredit: UILabel!
    @IBOutlet weak var btnCODRef: UIButton!
    @IBOutlet weak var btnCreditOrDebitRef: UIButton!
    
    @IBOutlet weak var lblMyPayment: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnAddCreditCard: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnConfirmRef: UIButton!
    //MARK: - Variables
    
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var payment_type = String()
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
    var locationManager = CLLocationManager()
    let realm = try! Realm()
    var CardModelArray = [CardModel]()
    
    

    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - View life cycle methods
    //TODO: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    //TODO: View Will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    @IBAction func btnCreditCardTapped(_ sender: UIButton) {
        let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: AddCardVC.className) as! AddCardVC
        viewC.isComing = "PAYM"
        viewC.objMode = self
        self.navigationController?.present(viewC, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func btnPayMode(_ sender: Any) {
        
        if (sender as AnyObject).tag == 1{
            btnCODRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
            btnCreditOrDebitRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            payment_type = "COD"
        }else{
            btnCODRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnCreditOrDebitRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
            payment_type = "PTA NAI"
        }
        
        
    }
    
    
    @IBAction func btnDone(_ sender: Any) {
        
        let orders = realm.objects(OrderItem.self)
        
        if orders.count != 0 {
            print("yaha api hit kaaran hai")
            }else{
             placeOrderService()
        }
   
    }
    
    
    
    @objc func btnDeleteTap(_sender: UIButton) {
        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.deleteReq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
            if isOtherButton == true {
                print("Cancel Button  Pressed", terminator: "")
            }
            else
            {
                self.deleteCardService(cardId:self.CardModelArray[_sender.tag].id,index:_sender.tag)
            }
            
        }
        
    }
    func callApi() {
         macroObj.hideLoaderEmpty(view: collectionView)
        getCardList()
    }
}



//MARK: - Extension Location Delegates
extension PaymentModeVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.latitude = String(currentLocation.coordinate.latitude)
        self.longitude = String(currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
        
    }
    
    
    
    func reverseGeocodeCoordinate(inLat:Double, inLong:Double) {
        
        let cordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: inLat, longitude: inLong)
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(cordinate) { response, error in
            if let address = response?.results() {
                let lines = address.first
                print(lines)
                if let addressNew = lines?.lines {
                    self.address = self.makeAddressString(inArr: addressNew)
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
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension PaymentModeVC: CLLocationManagerDelegate {
    
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
