//
//  OfferVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class OfferVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblOrders: UITableView!
    
    
    //MARK: - Variables
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var favModelArray = [OfferListDataModel]()
    var isComing = String()
    var isCominng = String()
    var offerArray = [CartOfermodel]()
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationSetup()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        macroObj.hideLoaderEmpty(view: self.tblOrders)
        macroObj.hideLoaderNet(view: self.tblOrders)
        macroObj.hideWentWrong(view: self.tblOrders)
        if isCominng == "Cart"{
            
        }
        else{
            offerService()
            // favResService()
        }
        
        refreshControl.endRefreshing()
    }
    
}
