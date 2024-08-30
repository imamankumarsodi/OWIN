//
//  TopUpOffersVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//
import UIKit
import SwiftyJSON
import  Alamofire
import RealmSwift

class TopUpOffersVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var btnLoginRef: UIButton!
    @IBOutlet weak var tblAddOns: UITableView!
    //MARK: - Variables
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    let realm = try! Realm()
    var topup_id = String()
    internal var dataStore = [TopupList]()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
        initialSetup()
        
    }
    
    //TODO: View Will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetup()
        
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
   
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        if topup_id == ""{
             _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.selectWallet, style: AlertStyle.error)
        }else{
            addWalletService()
        }
        
        
       
        
        
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        topuplist()
        
        refreshControl.endRefreshing()
    }
    
    func topuplist()
    {
        if InternetConnection.internetshared.isConnectedToNetwork(){
      self.macroObj.showLoader(view: self.view)
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            if dataStore.count > 0{
                dataStore.removeAll()
            }
            let header = ["Content-Type":"application/json",
                          "Authorization":"\(token_type) \(access_token)"]
            alamoFireObj.getRequestURL(MacrosForAll.APINAME.topuplist.rawValue, headers: header, success: { (resJson) in
                print(resJson)
                if let status = resJson["status"].stringValue as? String{
                     self.macroObj.hideLoader(view: self.view)
                    if let dataArray = resJson["topupList"].arrayObject as? NSArray{
                        var priceR = Int()
                        var idR = Int()
                        var descriptionR = String()
                        for item in dataArray{
                            if let itemDict = item as? NSDictionary{
                                if let price = itemDict.value(forKey: "price") as? Int{
                                    priceR = price
                                }
                                if let id = itemDict.value(forKey: "id") as? Int{
                                    idR = id
                                }
                                if let description = itemDict.value(forKey: "description") as? String{
                                    descriptionR = description
                                }
                                let itemmodel = TopupList(description: descriptionR, id: idR, price: priceR, isSelected: false)
                                self.dataStore.append(itemmodel)
                            }
                            
                        }
                        self.tblAddOns.reloadData()
                    }
                    
                }
                else{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = resJson["message"].stringValue as? String{
                         _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                }
               
            }, failure: { (Error) in
             
                self.macroObj.hideLoader(view: self.view)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
            })
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    
    
    
    
    fileprivate func addWalletService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            var token_type = String()
            var access_token = String()
            
            if let userInfo = realm.objects(SignupDataModel.self).first{
                token_type = userInfo.token_type
                access_token = userInfo.access_token
            }
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
            
            let passDict = ["topup_id":topup_id] as [String:AnyObject]
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.addwallet.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    self.macroObj.hideLoader(view: self.view)
                    
                    
                    if let addWallet = responseJASON["addWallet"].intValue as? Int{
                        self.updateUser(wallet: addWallet)
                    }
                    
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.success)
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                    
                }else{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                    
                }
                
            }, failure: { (error) in
                self.macroObj.hideLoader(view: self.view)
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
                
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    func updateUser(wallet:Int){
        do{
            try realm.write {
                
                if let user = realm.objects(SignupDataModel.self).first{
                    user.wallet = wallet
                }
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }
}
