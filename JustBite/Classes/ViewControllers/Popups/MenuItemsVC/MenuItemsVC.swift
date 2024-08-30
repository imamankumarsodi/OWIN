//
//  MenuItemsVC.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

protocol BackDataToRetDetails {
    func backDataToDetilsReload(index1:Int)
}

class MenuItemsVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblAddOns: UITableView!
    
    
    //MARK: - Variables
    internal var previousOffset: CGFloat = 0
    var protObj:BackDataToRetDetails?
    var categoryDataModelArray = [CategoryDataModel]()
    
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
        super.hideStatusBar(true)
    }
    
    //MARK: - Actions,Gesture
    //TODO: Save Actions
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
