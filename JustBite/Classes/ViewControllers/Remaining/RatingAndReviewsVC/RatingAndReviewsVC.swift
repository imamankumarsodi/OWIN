//
//  RatingAndReviewsVC.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import Cosmos

class RatingAndReviewsVC:  BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblAddOns: UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewCosmos: CosmosView!
    //MARK: - Variables
    var id = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var reviewDataModelArray = [RestaurentReviewModel]()
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
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        macroObj.hideLoaderEmpty(view: self.tblAddOns)
        macroObj.hideLoaderNet(view: self.tblAddOns)
        macroObj.hideWentWrong(view: self.tblAddOns)
        hitRestInfoService(id:self.id)
        refreshControl.endRefreshing()
       
    }
    
   
    
}
