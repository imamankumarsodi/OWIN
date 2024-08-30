//
//  EditProfileVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import MaterialComponents.MaterialTextFields
import CoreLocation
import RealmSwift

class EditProfileVC: BaseViewController ,SendDataToEditProfile{
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblProfile: TPKeyboardAvoidingTableView!
    
    @IBOutlet weak var txtAppartment: MDCTextField!
    @IBOutlet weak var txtFloor: MDCTextField!
    
    //MARK: - OUTLETS FOR MVC
    
    @IBOutlet weak var txtBuilding: MDCTextField!
    @IBOutlet weak var txtFieldFirstName: MDCTextField!
    
    @IBOutlet weak var txtFieldLastName: MDCTextField!
    
    @IBOutlet weak var txtEmail: MDCTextField!
    
    @IBOutlet weak var txtCountryCode: MDCTextField!
    
    @IBOutlet weak var txtPhoneNumber: MDCTextField!
    
    @IBOutlet weak var imgViewCountryCode: UIImageView!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var txtArea: MDCTextField!
    
    @IBOutlet weak var txtHouse: MDCTextField!
    
    @IBOutlet weak var txtPin: MDCTextField!
    
    @IBOutlet weak var txtLM: MDCTextField!
    
    
    @IBOutlet weak var btnOffieceRef: UIButton!
    @IBOutlet weak var btnHomeRef: UIButton!
    @IBOutlet weak var btnAddressTypeRef: UIButton!
    @IBOutlet weak var btnEditProfileRef: UIButton!
    
    //MARK: - Varibles for class
    
    var textFieldControllerFloatingFirstName: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingLastName: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingEmail: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingCountryCode: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingPhoneNumber: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingArea: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingHouse: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingPin: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingLM: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingBuilding: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingtxtAppartment: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingtxtFloor: MDCTextInputControllerUnderline?
    
    var locationManager = CLLocationManager()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var lat = String()
    var long = String()
    internal var address_type = String()
    let validation:Validation = Validation.validationManager() as! Validation
    
    let realm = try! Realm()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
  //  let footer:AddressFooterForMyProfile = Bundle.main.loadNibNamed("AddressFooterForMyProfile", owner: self, options: nil)!.last! as! AddressFooterForMyProfile
    
    
    internal var profileModel: editProfileModeling?
    internal var dataStore1 = [DataStoreStruct]()
    internal var dataStore2 = [DataStoreStruct]()
    
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
    
    @objc func tapSectionBtn(sender:UIButton){
        super.goBackToIndex(1, animated: true)
        
    }
    
    
    @IBAction func tap_countryCode(_ sender: UIButton) {
        
        let vc = AppStoryboard.remain.instantiateViewController(withIdentifier: SRCountryPickerController.className) as! SRCountryPickerController
        vc.countryDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        validationSetup()
    }
    
    @IBAction func btnHomeTapped(_ sender: UIButton) {
        self.address_type = "0"
        btnHomeRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
        btnOffieceRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
        btnHomeRef.setTitleColor(AppColor.themeColor, for: .normal)
        btnOffieceRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
    }
    
    @IBAction func btnOfficeTapped(_ sender: Any) {
        self.address_type = "1"
        btnHomeRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
        btnOffieceRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
        btnHomeRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
        btnOffieceRef.setTitleColor(AppColor.themeColor, for: .normal)
    }
    
    @IBAction func btnAreaTapped(_ sender: UIButton) {
        let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LocationPickerVC.className) as! LocationPickerVC
        viewC.isComing = "EDT_PROF"
        viewC.backEditProfileObj = self
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    func backToAddress(area: String, landmark: String, pincode: String, address: String,lat:String,long:String) {
        
        txtArea.text = address
      //  txtHouse.text = address
        txtPin.text = pincode
        txtLM.text = landmark
        self.lat = lat
        self.long = long
    }
    
}
//MARK:- Country Picker Delegate

extension EditProfileVC : CountrySelectedDelegate {
    func SRcountrySelected(countrySelected country: Country, imagePath: String) {
        self.txtCountryCode.text = country.dial_code
        self.imgViewCountryCode.image = UIImage(named: imagePath)
    }
    
}


//MARK: - Extension Location Delegates
extension EditProfileVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.lat = String(currentLocation.coordinate.latitude)
        self.long = String(currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension EditProfileVC: CLLocationManagerDelegate {
    
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
