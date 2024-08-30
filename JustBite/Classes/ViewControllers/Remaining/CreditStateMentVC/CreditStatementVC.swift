//
//  CreditStatementVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class CreditStatementVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblViewDrawer: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    let realm = try! Realm()
    internal var dataStore = [TopupHistoryList]()
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    
    //TODO: View will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUP()
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        topuplist()
        
        refreshControl.endRefreshing()
    }
    
}
