//
//  HomeTableViewCellCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension HomeTableViewCell{
    
    //TODO: InitialSetup
    //TODO: InitialSetup
    public func configureCellWith(info: RestaurentDataModelForHome){
        GlobalCustomMethods.shared.provideCornarRadius(btnRef: heartView)
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: mainView, radius: 5)
        GlobalCustomMethods.shared.provideShadow(btnRef: mainView)
        
        let doubleRating = Double(info.rating) as? Double ?? 0.0
        let str1 = String(format: "%.1f", doubleRating) // 3.14
        
         disLbl.text = getDistanceFromCurrentToAll(currentLocationLat:Double(info.latitudeCur) ?? 0.0, currentLocationLong:Double(info.longitudeCur) ?? 0.0, latitude: info.latitude, longitude: info.longitude)
        
        lblDetails.attributedText = GlobalCustomMethods.shared.updateHomeTableViewCellLabel(title: info.name, cusineArray: info.cuisines, address: info.address, delemit: "\n")
        lblRatingReview.text = "\(str1) (\(info.review) Reviews)"
        viewCosmos.rating = Double(info.rating) as? Double ?? 0.0
        viewCosmos.settings.fillMode = .half
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
