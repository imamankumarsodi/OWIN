//
//  SearchVC.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class SearchVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var search_bar: UISearchBar!
    
    //MARK: - Variables
    var locationManager = CLLocationManager()
    var lat = String()
    var long = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var favModelArray = [RestaurentDataModelForHome]()
    var filtered = [RestaurentDataModelForHome]()
    var cuisinesNameArray = [String]()
    var cuisinesIdArray = [Int]()
    var cuisinesNameArray1 = [String]()
    var cuisinesIdArray1 = [Int]()
    var searchActive = false
    
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
        AccessCurrentLocationuser()
   
    
}
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    @IBAction func btnFilterRef(_ sender: UIButton) {
        
        let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: RestaurentsFilterPopUpVC.className) as! RestaurentsFilterPopUpVC
        viewC.delegate = self
        self.navigationController?.present(viewC, animated: true, completion: nil)
        
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        macroObj.hideLoaderEmpty(view: self.tblView)
        macroObj.hideLoaderNet(view: self.tblView)
        macroObj.hideWentWrong(view: self.tblView)
        AccessCurrentLocationuser()
        refreshControl.endRefreshing()
    }
    
    @objc func reloadHomeApi(_ notification: Notification){
        favResService()
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
                    let token_type = userInfo.token_type
                    let access_token = userInfo.access_token
                    var id = String()
                    var isFav = String()
                    if let restId = favModelArray[sender.tag].id as? String{
                        id = restId
                    }
                    
                    if let isFavo = favModelArray[sender.tag].is_favorite as? String{
                        isFav = isFavo
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
