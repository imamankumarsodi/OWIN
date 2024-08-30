//
//  NotificationsViewController.swift
//  JustBite
//
//  Created by cst on 30/01/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class NotificationsViewController: BaseViewController {

    
    @IBOutlet weak var notificationTV: UITableView!
    
    var notificationArray = [Notification_Model]()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
      //  navigationSetUp()
        initialSetUp()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationSetUp()
    }

}
