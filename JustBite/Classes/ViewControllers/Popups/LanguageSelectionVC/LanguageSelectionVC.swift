//
//  LanguageSelectionVC.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class LanguageSelectionVC: BaseViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var btnNextRef: UIButton!
    
    
    let realm = try! Realm()
    var locationManager = CLLocationManager()
    //MARK: - View Life Cycle Methods
    //TODO: View didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initialStup()
        // Do any additional setup after loading the view.
    }
    
    //TODO: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        super.hideNavigationBar(true)
    }
    
    //MARK: - Actions,Gesture
    //TODO: Save Actions
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
       
        
        if sender.tag == 0{
            
            do{
                try realm.write {
                    
                    
                    if let user = realm.objects(SignupDataModel.self).first{
                        user.xLoc = "en"
                    }else{
                        let signup_data = SignupDataModel()
                        signup_data.xLoc = "en"
                        realm.add(signup_data)
                    }
                }
            }catch{
                print("Error in saving data :- \(error.localizedDescription)")
            }
            
                    moveToHomeVC()
        }else{
            
            do{
                try realm.write {
                    
                    if let user = realm.objects(SignupDataModel.self).first{
                        user.xLoc = "ar"
                    }else{
                        let signup_data = SignupDataModel()
                        signup_data.xLoc = "ar"
                        realm.add(signup_data)
                    }
                }
            }catch{
                print("Error in saving data :- \(error.localizedDescription)")
            }
            
            moveToHomeVC()
            
           // super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
            
        }
        
        
        
    }
    
    
}


//MARK: - Extension Location Delegates
extension LanguageSelectionVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation:CLLocation = locations.first!
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}

//MARK: - Extension Method Access Current Location
extension LanguageSelectionVC: CLLocationManagerDelegate {
    
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
