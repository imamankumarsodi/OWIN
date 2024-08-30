//
//  TopNearByMyFavoriteVC.swift
//  JustBite
//
//  Created by Aman on 10/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift
class TopNearByMyFavoriteVC:BaseViewController {

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblView: UITableView!
    
    
    //MARK: - Variables
    
    var locationManager = CLLocationManager()
    var lat = String()
    var long = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var headertitle = String()
    var topResModelArray = [RestaurentDataModelForHome]()
    var nearByModelArray = [RestaurentDataModelForHome]()
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
    }
    
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
        
        macroObj.hideLoaderEmpty(view: self.tblView)
        macroObj.hideLoaderNet(view: self.tblView)
        macroObj.hideWentWrong(view: self.tblView)
          if headertitle == "Top Rated Restaurents"{
            topResService()
        }else if headertitle == "Near-by Restaurents"{
            AccessCurrentLocationuser()
        }else{
            
        }
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        //filterStatus = false
        macroObj.hideLoaderEmpty(view: self.tblView)
        macroObj.hideLoaderNet(view: self.tblView)
        macroObj.hideWentWrong(view: self.tblView)
        if headertitle == "Top Rated Restaurents"{
            topResService()
        }else if headertitle == "Near-by Restaurents"{
            AccessCurrentLocationuser()
        }else{
            
        }
        refreshControl.endRefreshing()
    }
    
    @objc func reloadHomeApi(_ notification: Notification){
        if headertitle == "Top Rated Restaurents"{
            topResService()
        }else if headertitle == "Near-by Restaurents"{
            AccessCurrentLocationuser()
        }else{
            
        }
    }

    @objc func btnLocationTapped(sender: UIButton){
        if headertitle == "Top Rated Restaurents"{
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(topResModelArray[sender.tag].latitudeCur),\(topResModelArray[sender.tag].longitudeCur)&directionsmode=driving")! as URL)
                print("Sonika----->")
            } else {
                NSLog("Can't use comgooglemaps://");
            }
        }
        else{
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(nearByModelArray[sender.tag].latitudeCur),\(nearByModelArray[sender.tag].longitudeCur)&directionsmode=driving")! as URL)
                print("Sonika----->")
            } else {
                NSLog("Can't use comgooglemaps://");
            }
        }
       
    }
    
    @objc func btnFavTapped(sender: UIButton){
        
        
        
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
            if userInfo.id == ""{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        print("Cancel Button  Pressed", terminator: "")
                        //                        self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                    }
                    else
                    {
                        self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                    }
                    
                }
            }else{
                print(sender.tag)
                
                let realm = try! Realm()
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    //api call kara do
                    var token_type = userInfo.token_type
                    var access_token = userInfo.access_token
                    var id = String()
                    var isFav = String()
                    
                    
                    if headertitle == "Top Rated Restaurents"{
                        if let restId = topResModelArray[sender.tag].id as? String{
                            id = restId
                        }
                        
                        if let isFavo = topResModelArray[sender.tag].is_favorite as? String{
                            isFav = isFavo
                        }
                        
                    }else if headertitle == "Near-by Restaurents"{
                        if let restId = nearByModelArray[sender.tag].id as? String{
                            id = restId
                        }
                        
                        if let isFavo = nearByModelArray[sender.tag].is_favorite as? String{
                            isFav = isFavo
                        }
                    }else{
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    guard let indexpath = IndexPath(row: sender.tag, section: 0) as? IndexPath else{
                        print("No indexpath")
                        return
                    }
                    
                    guard let collCell = tblView.cellForRow(at: indexpath) as? HomeTableViewCell else{
                        print("No collCell")
                        return
                    }
                    
                    addFavService(token_type: token_type, access_token: access_token, view: collCell.heartView, id: id, isFav: isFav, index: sender.tag, cell: collCell)
                    
                }else{
                    
                    print("Pop up dikhao bahar bhagao")
                    
                }
                
            }
        }else{
            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    print("Cancel Button  Pressed", terminator: "")
                    //                    self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                }
                else
                {
                    self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                }
                
            }
            print("do nothing")
        }
     
    }
    
    
}
