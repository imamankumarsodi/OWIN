//
//  LocationPickerCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 01/07/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import DropDown

extension LocationPickerVC:GMSMapViewDelegate{
    
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        ScreeNNameClass.shareScreenInstance.screenName = LocationPickerVC.className

        search_bar.delegate = self
        super.hideNavigationBar(false)
        self.viewSearch.backgroundColor = AppColor.whiteColor
        self.search_bar.placeholder = "Search by Restaurants, Dishes, Cusines"
        self.search_bar.backgroundImage = UIImage()
        
        self.btnSubmit.backgroundColor = AppColor.stepperColor
        self.btnSubmit.setTitle("Confirm", for: .normal)
        self.btnSubmit.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: self.viewSearch)
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewSearch, radius: self.viewSearch.frame.size.height/2)
        placesClient = GMSPlacesClient.shared()
        locationManager.delegate = self
        self.mapView.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        self.placesClient = GMSPlacesClient()
        
        hideKeyboardWhenTappedAround()
        
        
    }
    
    
    
    
    
    // TODO: DateDrop downs
    
    
    
    
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.setupNavigationBarTitle("Map", leftBarButtonsType: [.back], rightBarButtonsType: [])
        
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: LocationPickerVC.className)
        super.transparentNavigation()
        super.hideNavigationBar(false)
        
        DropDown.appearance().selectionBackgroundColor = UIColor.clear
        dropDown.backgroundColor = UIColor.white
        
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.txtAddress.text = "\(item)"
                
                
                
               
                
                if let itemData = self.resArray[index] as? GMSAutocompletePrediction{
                    
                    if let placeID = itemData.placeID as? String{
                        let placesClient = GMSPlacesClient.shared()
                        placesClient.lookUpPlaceID(placeID) { (place, error) in
                            if let error = error {
                                print("lookup place id query error: \(error.localizedDescription)")
                                return
                            }
                            
                            guard let place = place else {
                                print("No place details for \(placeID)")
                                return
                            }
                            
                            let searchedLatitude = place.coordinate.latitude
                            let searchedLongitude = place.coordinate.longitude
                            
                            self.mapView.clear()
                            
                            let camera = GMSCameraPosition.camera(withLatitude:searchedLatitude ,longitude: searchedLongitude ,zoom:10)
                            self.mapView.camera = camera
                            let position = CLLocationCoordinate2D(latitude: searchedLatitude, longitude: searchedLongitude)
                            let marker = GMSMarker(position: position)
                            
                            marker.icon = UIImage(named: "map_location_ic")
                            marker.title = item
                            marker.map = self.mapView
                            self.search_bar.text = item
                            self.address = item
                            self.mapView.isMyLocationEnabled = true
                            
                            self.lat = searchedLatitude
                            self.long = searchedLongitude
                            
                            self.reverseGeocodeCoordinate(inLat:searchedLatitude, inLong:searchedLongitude)
                            
                            print("THE SEARCHED LATITUDE", searchedLatitude)
                            print("THE SEARCHED LONGITUDE", searchedLongitude)
                            
                           
                        }
                    }
                }
                
                
        }
        
        
    }
    func reverseGeocodeCoordinate(inLat:Double, inLong:Double) {
        
        let cordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: inLat, longitude: inLong)
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(cordinate) { response, error in
            
            if let address = response?.results() {
                
                let lines = address.first
                
                print(lines)
                
                if let addressNew = lines?.lines {
                    self.area = lines?.locality ?? ""
                    self.pincode = lines?.postalCode ?? ""
                    self.landmark = lines?.administrativeArea ?? ""
                    
//                    self.strAddress = self.makeAddressString(inArr: addressNew)
//
//                    self.lblAddress.text = self.strAddress
//
//                    print(self.strAddress)
                    self.configureMap()
//
                    self.dropMapPin()
                    
                    self.txtAddress.text = self.makeAddressString(inArr: addressNew)
                    self.search_bar.text = self.makeAddressString(inArr: addressNew)
                    self.address = self.makeAddressString(inArr: addressNew)
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
    
    func dropMapPin(){
        
        self.mapView.clear()
        let marker = GMSMarker()
        marker.icon = UIImage(named:"map_location_ic")
        marker.position = CLLocationCoordinate2D(latitude: Double(self.lat), longitude: Double(self.long))
        marker.isDraggable = true
        marker.map = self.mapView
    }
    
    func makeAddressString(inArr:[String]) -> String {
        
        var fVal:String = ""
        for val in inArr {
            
            fVal =  fVal + val + " "
            
        }
        return fVal
        
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        
        self.mapView.clear()
        
        print("marker dragged to location: \(marker.position.latitude),\(marker.position.longitude)")
        
        self.lat = marker.position.latitude
        self.long = marker.position.longitude
        
        self.reverseGeocodeCoordinate(inLat: self.lat, inLong: self.long)
    }
    
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
        print("Begin Dragging")
    }
    
}


// MARK: - Search extensions

extension LocationPickerVC:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == ""{
            searchActive = false
        }else{
            searchActive = true
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.search_bar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if resultArray.count > 0{
            resultArray.removeAllObjects()
        }
        if resArray.count > 0{
            resArray.removeAll()
        }
        
        
        
        
        if searchBar.text!.isEmpty {
            searchActive = false
        }
        else {
            searchActive = true
            let text = search_bar.text!
            if text.count > 0{
              apiCallForshowPlaces(newText : text)
            }
        }

    }
    
    
    
    func apiCallForshowPlaces(newText : String){
        
        let filter = GMSAutocompleteFilter()
        
        filter.type = GMSPlacesAutocompleteTypeFilter.establishment
        
        let placesClient = GMSPlacesClient()
        
        placesClient.autocompleteQuery(newText, bounds: nil, filter: filter, callback: { (result, error) -> Void in
            
            if self.resultArray.count > 0{
                self.resultArray.removeAllObjects()
            }
            if self.resArray.count > 0{
                self.resArray.removeAll()
            }
            
            
            guard result != nil else {
                return
            }
            
            for item in result! {
                
                if let res: GMSAutocompletePrediction = item {
                    
                    self.resultArray.add(res.attributedFullText.string)
                    self.resArray.append(res)
                    
                    
                }
            }
            
            self.dropDown.anchorView = self.search_bar
            self.dropDown.width = self.search_bar.frame.size.width
            self.dropDown.dataSource = self.resultArray as! [String]
            self.dropDown.bottomOffset = CGPoint(x: 0, y:self.search_bar.bounds.height)
            self.dropDown.direction = .bottom
            self.dropDown.show()
            
        })
    }
    
    
    func configureMap(){
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 12.0)
        mapView.camera = camera
        locationManager.delegate = self
        mapView.isMyLocationEnabled = true
        
    }
    
}


extension LocationPickerVC:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            
            let currentLocation:CLLocation = locations.first!
            manager.stopUpdatingLocation()
            
            let lat:Double = currentLocation.coordinate.latitude
            let long:Double = currentLocation.coordinate.longitude
            
            self.lat = currentLocation.coordinate.latitude
            self.long = currentLocation.coordinate.longitude
            
            self.reverseGeocodeCoordinate(inLat: lat, inLong: long)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        NSLog("error = %@", error.localizedDescription)
        
    }
    
    func locationAuthorizationStatus(status:CLAuthorizationStatus)
    {
        switch status
        {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location AuthorizedWhenInUse/AuthorizedAlways")
            self.mapView.isMyLocationEnabled = true
            
            self.locationManager.startUpdatingLocation()
            if CLLocationManager.headingAvailable() {
                self.locationManager.headingFilter = 100
            }
            
        case .denied, .notDetermined, .restricted:
            print("Location Denied/NotDetermined/Restricted")
            self.mapView.isMyLocationEnabled = false
            self.locationManager.stopUpdatingLocation()
            
        }
        
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
        {
        }
        
        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
        {
        }
        
        func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion)
        {
            print("Now monitoring :  \(manager.location?.coordinate) for \(region.identifier) radius: \(region.identifier)")
        }
        
        func locationManager(_ manager: CLLocationManager,
                             monitoringDidFailFor region: CLRegion?, withError error: Error)
        {
            print("monitoringDidFailForRegion \(region!.identifier) \(error.localizedDescription) \(error.localizedDescription)")
        }
        
        func locationManager(_ manager: CLLocationManager,
                             didDetermineState state: CLRegionState, for region: CLRegion)
        {
            var stateName = ""
            switch state {
            case .inside:
                stateName = "Inside"
            case .outside:
                stateName = "Outside"
            case .unknown:
                stateName = "Unknown"
            }
            print("didDetermineState \(stateName) \(region.identifier)")
            
        }
    }
}
