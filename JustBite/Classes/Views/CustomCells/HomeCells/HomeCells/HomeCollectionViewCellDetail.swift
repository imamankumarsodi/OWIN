//
//  HomeCollectionViewCellDetail.swift
//  JustBite
//
//  Created by Aman on 09/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
import CoreLocation

class HomeCollectionViewCellDetail: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var imgResaurent: UIImageView!
    @IBOutlet weak var viewCosmos: CosmosView!
    @IBOutlet weak var lblRatingReview: UILabel!
    @IBOutlet weak var btnFavRef: UIButton!
    
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var disLbl: UILabel!
    
    var lat = String()
    var long = String()
    
    var locationManager = CLLocationManager()
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
    
    
    //TODO: InitialSetup
    public func configureCellWith(info: RestaurentDataModelForHome){
        
        
        
        print(info.img)
        print(info.rating)
        print(info.review)
        
    
        
    
        GlobalCustomMethods.shared.provideCornarRadius(btnRef: heartView)
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: mainView, radius: 5)
        GlobalCustomMethods.shared.provideShadow(btnRef: mainView)
        lblDetails.attributedText = GlobalCustomMethods.shared.updateHomeTableViewCellLabel(title: info.name, cusineArray: info.cuisines, address: info.address, delemit: "\n")
        
        
        var latitude = info.latitude
        var longitude = info.longitude
        
        
        
        disLbl.text = getDistanceFromCurrentToAll(currentLocationLat:Double(info.latitudeCur) ?? 0.0, currentLocationLong:Double(info.longitudeCur) ?? 0.0, latitude: latitude, longitude: longitude)
        lblRatingReview.text = "\(String(format: "%.1f", Double(info.rating) as? Double ?? 0.0)) (\(info.review) Reviews)"
        
        viewCosmos.settings.fillMode = .half
        
        viewCosmos.rating = Double(info.rating) as? Double ?? 0.0
        self.imgResaurent.sd_setImage(with: URL(string: info.img), placeholderImage: UIImage(named: "user_signup"))
        self.imgResaurent.clipsToBounds = true
        if info.is_favorite == "0"{
            btnFavRef.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
        }else{
            btnFavRef.setImage(#imageLiteral(resourceName: "heart_like_"), for: .normal)
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


//MARK: - Extension Location Delegates
extension HomeCollectionViewCellDetail {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.lat = String(currentLocation.coordinate.latitude)
        self.long = String(currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
       // nearByResService()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension HomeCollectionViewCellDetail: CLLocationManagerDelegate {
    
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
           // self.present(locationAlert, animated: true, completion: nil)
        }
    }
}
