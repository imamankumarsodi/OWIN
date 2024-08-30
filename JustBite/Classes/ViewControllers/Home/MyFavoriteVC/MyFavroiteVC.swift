//
//  MyFavroiteVC.swift
//  JustBite
//
//  Created by Aman on 19/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift
class MyFavroiteVC:BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblView: UITableView!
    
    
    //MARK: - Variables
    
    
   
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var favModelArray = [RestaurentDataModelForHome]()
    
    
    var gotLat = String()
    var gorLong = String()
    
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
        
        
        
        gotLat  = UserDefaults.standard.value(forKey: "latitude") as? String ?? ""
        gorLong = UserDefaults.standard.value(forKey: "longitude") as? String ?? ""
        
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
          navigationSetUpView()
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
            favResService()
        refreshControl.endRefreshing()
    }
    
    @objc func reloadHomeApi(_ notification: Notification){
            favResService()
    }
    
    @objc func btnFavTapped(sender: UIButton){
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
    
    
}
