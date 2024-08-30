//
//  HomeVC.swift
//  JustBite
//
//  Created by Aman on 09/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: BaseViewController,SendDataToHome {
    
    func backToAddress(address: String, lat: Double, lon: Double) {
        self.address = address
        txtFieldHeader.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 14)
        txtFieldHeader.textColor = AppColor.whiteColor
        txtFieldHeader.text = address
        self.lat = String(lat)
        self.long = String(long)
        homeService()
    }
    

    //MARK: - IBOutlets
    @IBOutlet weak var tblViewHome: UITableView!
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var txtFieldHeader: UITextField!
    @IBOutlet weak var heightHeader: NSLayoutConstraint!
   
    var locationManager = CLLocationManager()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var lat = String()
    var long = String()
    
    var address = String()
    
    
    //Home Variables
    var nearByModelArray = [RestaurentDataModelForHome]()
    var topResModelArray = [RestaurentDataModelForHome]()
    var OffersDataModelArray = [RestaurentDataModelForHome]()
    var homeListModelArray = [HomeListingModel]()
    
  
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeVC.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
    }
    //MARK: - View life cycle methods
    //TODO: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
          self.tabBarController?.tabBar.isHidden = false
    }
    
    //TODO: View Will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
         self.tabBarController?.tabBar.isHidden = false
        initialSetup()
        if address == ""{
            AccessCurrentLocationuser()
        }else{
            print("Do nothing")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         self.tabBarController?.tabBar.isHidden = false
        initialSetup()
        if MAIN_SCREEN_HEIGHT == 812 || MAIN_SCREEN_HEIGHT == 896{
            heightHeader.constant = 90
        }else{
            heightHeader.constant = 60
            
        }
        
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.viewHeader.bounds
    }
    
    @IBAction func btnHeaderTapped(_ sender: UIButton) {
        
        if sender.tag == 1{
            super.menuTapped()
        }else{
            super.cartTapped()
        }
    }
    
    @IBAction func btnLocationTapped(_ sender: UIButton) {
        let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LocationPickerVC.className) as! LocationPickerVC
       viewC.sendDataHomeObj = self
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    
    @objc func tapSectionBtn(sender:UIButton){
        if sender.tag == 0{
            let viewC = UIStoryboard(name: "Remaining", bundle: nil).instantiateViewController(withIdentifier: OfferVC.className) as! OfferVC
            viewC.isComing = "HOME"
            self.navigationController?.pushViewController(viewC, animated: true)
        }else if sender.tag == 1{
            let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: TopNearByMyFavoriteVC.className) as! TopNearByMyFavoriteVC
            viewC.headertitle = "Top Rated Restaurents"
            self.navigationController?.pushViewController(viewC, animated: true)
        }else if sender.tag == 2{
            let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: TopNearByMyFavoriteVC.className) as! TopNearByMyFavoriteVC
            viewC.headertitle = "Near-by Restaurents"
            self.navigationController?.pushViewController(viewC, animated: true)
        }
        
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        homeService()
        
        refreshControl.endRefreshing()
    }
    
    @objc func reloadHomeApi(_ notification: Notification){
        homeService()
    }
    
    

}


//MARK: - Extension Location Delegates
extension HomeVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.lat = String(currentLocation.coordinate.latitude)
        self.long = String(currentLocation.coordinate.longitude)
        
        reverseGeocodeCoordinate(inLat:currentLocation.coordinate.latitude, inLong:currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
        homeService()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension HomeVC: CLLocationManagerDelegate {
    
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
