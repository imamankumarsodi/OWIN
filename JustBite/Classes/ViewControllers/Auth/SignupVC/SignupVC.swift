//
//  SignupVC.swift
//  JustBite
//
//  Created by Aman on 06/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import MaterialComponents.MaterialTextFields
import CoreLocation

class SignupVC: BaseViewController,SendDataToSignup {
    
    
    
    //MARK: - IBOutlets
    
    
   
    @IBOutlet weak var imgPassword: UIImageView!
    @IBOutlet weak var imgCPassword: UIImageView!
    @IBOutlet weak var imgViewCountryCode: UIImageView!
    @IBOutlet weak var tblViewLogin: TPKeyboardAvoidingTableView!
    
    @IBOutlet weak var btnLoginRef: UIButton!
    
    //MARK: - OUTLETS FOR MVC
    
    @IBOutlet weak var txtFieldFirstName: MDCTextField!
    
    @IBOutlet weak var txtFieldLastName: MDCTextField!
    
    @IBOutlet weak var txtEmail: MDCTextField!
    
    @IBOutlet weak var txtCountryCode: MDCTextField!
    
    @IBOutlet weak var txtPhoneNumber: MDCTextField!
    
    @IBOutlet weak var txtAddress: MDCTextField!
    
    @IBOutlet weak var txtPassword: MDCTextField!
    
    @IBOutlet weak var txtConfirmPassword: MDCTextField!
    
    //MARK: - Varibles for class
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    var showPasswordStatus = Bool()
    var showConfirmPasswordStatus = Bool()
    
    
    internal var loginModel: LoginModeling?
    internal var dataStore = [DataStoreStruct]()
    let validation:Validation = Validation.validationManager() as! Validation
    var locationManager = CLLocationManager()
    
    var textFieldControllerFloatingFirstName: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingLastName: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingEmail: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingCountryCode: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingPhoneNumber: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingAddress: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingPassword: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingConfirmPassword: MDCTextInputControllerUnderline?
    
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var lat = String()
    var long = String()
    
    //MARK: - View life cycle methods
    //TODO: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    //TODO: View will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    
    
    //MARK: - Actions, Tap gestures
    //TODO: Login Tapped
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        
        
        validationSetup()
        
        
    }
    
    @IBAction func tap_countryCode(_ sender: UIButton) {
        
        let vc = AppStoryboard.remain.instantiateViewController(withIdentifier: SRCountryPickerController.className) as! SRCountryPickerController
        vc.countryDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addressTappedBtn(_ sender: UIButton) {
        let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LocationPickerVC.className) as! LocationPickerVC
        viewC.isComing = "SGN_Up"
        viewC.backSignupObj = self
        self.navigationController?.pushViewController(viewC, animated: true)
        
    }
    func backToAddress(address: String,lat:String,long:String) {
        txtAddress.text = address
       UserDefaults.standard.set(txtAddress.text, forKey: "address")
        print( UserDefaults.standard.set(txtAddress.text, forKey: "address"))
        self.lat = lat
        self.long = long
        print(address)
    }
    
    
    @IBAction func btnShowPasswordTapped(_ sender: UIButton) {
        txtPassword.isSecureTextEntry = showPasswordStatus ? true : false
        imgPassword.image = showPasswordStatus ? #imageLiteral(resourceName: "close_eye") : #imageLiteral(resourceName: "open_eye")
        showPasswordStatus = !showPasswordStatus
    }
    
    
    @IBAction func btnShowConfirmPasswordTapped(_ sender: UIButton) {
        txtConfirmPassword.isSecureTextEntry = showConfirmPasswordStatus ? true : false
        imgCPassword.image = showConfirmPasswordStatus ? #imageLiteral(resourceName: "close_eye") : #imageLiteral(resourceName: "open_eye")
        showConfirmPasswordStatus = !showConfirmPasswordStatus
    }
    
    
    @IBAction func countryPickCodeBtn(_ sender: Any) {
        
        let vc = AppStoryboard.remain.instantiateViewController(withIdentifier: SRCountryPickerController.className) as! SRCountryPickerController
        vc.countryDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}


//MARK:- Country Picker Delegate

extension SignupVC : CountrySelectedDelegate {
    func SRcountrySelected(countrySelected country: Country, imagePath: String) {
        self.txtCountryCode.text = country.dial_code
        self.imgViewCountryCode.image = UIImage(named: imagePath)
    }
    
}

//MARK: - Extension Location Delegates
extension SignupVC {
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
extension SignupVC: CLLocationManagerDelegate {
    
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
