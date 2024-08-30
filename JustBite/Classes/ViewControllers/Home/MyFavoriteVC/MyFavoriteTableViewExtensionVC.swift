//
//  MyFavoriteTableViewExtensionVC.swift
//  JustBite
//
//  Created by Aman on 19/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension MyFavroiteVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MyFavroiteVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblView.dequeueReusableCell(withIdentifier: HomeTableViewCell.className, for: indexPath) as? HomeTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.btnFavRef.tag = indexPath.row
        cell.btnFavRef.addTarget(self, action: #selector(btnFavTapped), for: .touchUpInside)
        
        var latitude = favModelArray[indexPath.row].latitude
        var longitude = favModelArray[indexPath.row].longitude
        
        var currentlat = favModelArray[indexPath.row].latitudeCur
        var currentLong = favModelArray[indexPath.row].longitudeCur
        
        cell.disLbl.text = getDistanceFromCurrentToAll(currentLocationLat:Double(currentlat) ?? 0.0, currentLocationLong:Double(currentLong) ?? 0.0, latitude: latitude, longitude: longitude)
        cell.configureCellWith(info: favModelArray[indexPath.row])
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
            let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
            vc.id = favModelArray[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    
    
}
