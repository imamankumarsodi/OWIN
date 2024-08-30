//
//  SearchTableViewDataSource.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

extension SearchVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
        
        if searchActive == true{
            vc.id = filtered[indexPath.row].id
        }else{
            vc.id = favModelArray[indexPath.row].id
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension SearchVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive == true{
            return filtered.count
        }else{
            return favModelArray.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblView.dequeueReusableCell(withIdentifier: HomeTableViewCell.className, for: indexPath) as? HomeTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.btnFavRef.tag = indexPath.row
        cell.btnFavRef.addTarget(self, action: #selector(btnFavTapped), for: .touchUpInside)
        
        
        cell.locationBtn.tag = indexPath.row
        cell.locationBtn.addTarget(self, action: #selector(btnLocationTapped), for: .touchUpInside)
        
        if searchActive == true{
            cell.configureCellWith(info: filtered[indexPath.row])
        }else{
            cell.configureCellWith(info: favModelArray[indexPath.row])
        }
        
        
        return cell
    }
    
    @objc func btnLocationTapped(sender:UIButton){
        
        
        if searchActive == true{
            
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(filtered[sender.tag].latitude),\(filtered[sender.tag].longitude)&directionsmode=driving")! as URL)
                
            } else {
                NSLog("Can't use comgooglemaps://");
            }
        }else{
            
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(favModelArray[sender.tag].latitude),\(favModelArray[sender.tag].longitude)&directionsmode=driving")! as URL)
                
            } else {
                NSLog("Can't use comgooglemaps://");
            }
            
        }
        
    }
}




extension SearchVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
}


//MARK: - Extension Location Delegates
extension SearchVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
        print("LATTITUDE IS:", currentLocation.coordinate.latitude)
        print("LONGITUDE IS:", currentLocation.coordinate.longitude)
        self.lat = String(currentLocation.coordinate.latitude)
        self.long = String(currentLocation.coordinate.longitude)
        self.locationManager.delegate = nil
        favResService()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension SearchVC: CLLocationManagerDelegate {
    
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
