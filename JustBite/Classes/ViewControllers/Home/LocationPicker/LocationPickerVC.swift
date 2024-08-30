//
//  LocationPickerVC.swift
//  JustBite
//
//  Created by Aman on 01/07/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import DropDown

protocol SendDataToHome {
    func backToAddress(address:String,lat:Double,lon:Double)
}
protocol  SendDataToEditProfile {
    func backToAddress(area:String,landmark:String,pincode:String,address:String,lat:String,long:String)
}
protocol SendDataToSignup{
    func backToAddress(address:String,lat:String,long:String)
}

protocol  SendDataToAddress {
    func backToAddress(area:String,landmark:String,pincode:String,address:String,lat:String,long:String)
}

protocol SendDataToCart{
    func backToAddress(address:String,lat:String,long:String)
}

class LocationPickerVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var txtAddress: UILabel!
    //MARK: - Variables
    
    var lat = Double()
    var long = Double()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var searchActive = false
    var resultArray : NSMutableArray = NSMutableArray()
    var resArray = [GMSAutocompletePrediction]()
    let dropDown = DropDown()
    var address = String()
    var placesClient : GMSPlacesClient?
    var sendDataHomeObj:SendDataToHome?
    var backEditProfileObj: SendDataToEditProfile?
    var backSignupObj:SendDataToSignup?
    var backCartObj:SendDataToCart?
    var backEditAddressObj:SendDataToAddress?
    var area = String()
    var pincode = String()
    var landmark = String()
    var isComing = String()
    var locationManager : CLLocationManager = CLLocationManager()
    
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
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        if isComing == "EDT_PROF"{
            
            self.backEditProfileObj?.backToAddress(area:area, landmark: landmark, pincode: pincode, address: address, lat: String(lat), long: String(long))
            self.navigationController?.popViewController(animated: true)
        } else if isComing == "SGN_Up"{
            self.backSignupObj?.backToAddress(address: address,lat:String(lat),long:String(long))
            self.navigationController?.popViewController(animated: true)
        }else if isComing == "EDT_ADDRESS"{
            self.backEditAddressObj?.backToAddress(area: self.area, landmark: self.landmark, pincode: self.pincode, address: address,lat:String(lat),long:String(long))
            self.navigationController?.popViewController(animated: true)
        }
        else if isComing == "Cart"{
            self.backCartObj?.backToAddress(address: address,lat:String(lat),long:String(long))
            self.navigationController?.popViewController(animated: true)
        }else {
            self.sendDataHomeObj?.backToAddress(address: address, lat: lat, lon: long)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
