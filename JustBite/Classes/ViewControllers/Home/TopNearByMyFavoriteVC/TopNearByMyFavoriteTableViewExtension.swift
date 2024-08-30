//
//  TopNearByMyFavoriteTableViewExtension.swift
//  JustBite
//
//  Created by Aman on 10/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension TopNearByMyFavoriteVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if headertitle == "Top Rated Restaurents"{
            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
            vc.id = topResModelArray[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
            vc.id = nearByModelArray[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension TopNearByMyFavoriteVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if headertitle == "Top Rated Restaurents"{
            return topResModelArray.count
        }else{
            return nearByModelArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblView.dequeueReusableCell(withIdentifier: HomeTableViewCell.className, for: indexPath) as? HomeTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.btnFavRef.tag = indexPath.row
        cell.btnFavRef.addTarget(self, action: #selector(btnFavTapped), for: .touchUpInside)
        
        cell.locationBtn.tag = indexPath.row
        cell.locationBtn.addTarget(self, action:  #selector(btnLocationTapped), for: .touchUpInside)
        
        if headertitle == "Top Rated Restaurents"{
            
            cell.configureCellWith(info: topResModelArray[indexPath.row])
           
        }else{
        
            cell.configureCellWith(info: nearByModelArray[indexPath.row])
            
        }
        
        
        return cell
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
extension TopNearByMyFavoriteVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.lat = String(currentLocation.coordinate.latitude)
        self.long = String(currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
        nearByResService()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension TopNearByMyFavoriteVC: CLLocationManagerDelegate {
    
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
